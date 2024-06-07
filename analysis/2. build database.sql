

-- CREATE SCHEMAS

    CREATE SCHEMA IF NOT EXISTS BRONZE ;
    CREATE SCHEMA IF NOT EXISTS GOLD   ;


-- CREATE TABLES

    CREATE OR REPLACE TABLE BRONZE.BIN                 AS FROM read_csv_auto('./files/data/bin.csv')                                    ;
    CREATE OR REPLACE TABLE BRONZE.COSTS               AS FROM read_csv_auto('./files/data/costs.csv', types = {'date' : 'VARCHAR'} )   ;
    CREATE OR REPLACE TABLE BRONZE.INVENTORY_STATUS    AS FROM read_csv_auto('./files/data/inventory_status.csv')                       ;
    CREATE OR REPLACE TABLE BRONZE.ITEM                AS FROM read_csv_auto('./files/data/item.csv')                                   ;
    CREATE OR REPLACE TABLE BRONZE.LOCATION            AS FROM read_csv_auto('./files/data/location.csv')                               ;
    CREATE OR REPLACE TABLE BRONZE.TRANSACTION_LINE    AS FROM read_csv_auto('./files/data/transaction_line.csv')                       ;

-- CREATE VIEWS

    -- ✅ BIN

        -- SELECT * FROM BIN

        CREATE OR REPLACE VIEW GOLD.DIM_BINS

        AS

        SELECT
                 id       AS BIN_ID
                ,name     AS BIN_NAME

        FROM
                BRONZE.BIN

        ;

        -- SELECT * FROM DIM_BINS ;

    -- ✅ COSTS

        -- SELECT * FROM COSTS  ;

        CREATE OR REPLACE VIEW GOLD.DIM_COSTS

        AS

        WITH

        START_DATE AS (

            SELECT
                     TRY_CAST( STRPTIME( date, '%m/%d/%Y' ) AS DATE )   AS COST_START_DATE
                    ,item_id                                            AS ITEM_ID
                    ,location_id                                        AS LOCATION_ID
                    ,cost                                               AS COST

            FROM
                    BRONZE.COSTS

            WHERE
                    1 = 1

        )

        SELECT
                 ITEM_ID
                ,LOCATION_ID
                ,COST
                ,COST_START_DATE
                ,LEAD( COST_START_DATE, 1 )
                 OVER(
                    PARTITION BY    ITEM_ID, LOCATION_ID
                    ORDER BY        COST_START_DATE
                 )                      AS COST_END_DATE

        FROM
                START_DATE

        WHERE
                1 = 1

        ORDER BY
                 ITEM_ID
                ,LOCATION_ID
                ,COST_START_DATE
                ,COST_END_DATE

        ;

        -- SELECT * FROM DIM_COSTS ;

    -- ✅ INVENTORY_STATUS

        -- SELECT * FROM INVENTORY_STATUS ;

        CREATE OR REPLACE VIEW GOLD.DIM_INVENTORY_STATUS

        AS

        SELECT
                 id     AS INVENTORY_STATUS_ID
                ,name   AS INVENTORY_STATUS_NAME

        FROM
                BRONZE.INVENTORY_STATUS

        ;

        -- SELECT * FROM DIM_INVENTORY_STATUS ;

    -- ✅ ITEM

        -- SELECT * FROM ITEM ;

        CREATE OR REPLACE VIEW GOLD.DIM_ITEMS

        AS

        SELECT
                 id     AS ITEM_ID
                ,name   AS ITEM_NAME

        FROM
                BRONZE.ITEM

        ;

        -- SELECT * FROM DIM_ITEMS ;

    -- ✅ LOCATION

        -- SELECT * FROM LOCATION ;

        CREATE OR REPLACE VIEW GOLD.DIM_LOCATIONS

        AS

        SELECT
                 id     AS LOCATION_ID
                ,name   AS LOCATION_NAME

        FROM
                BRONZE.LOCATION

        ;

        -- SELECT * FROM DIM_LOCATIONS ;

    -- DIM_DATES

        CREATE OR REPLACE VIEW GOLD.DIM_DATES

        AS

            WITH

            RANGES AS (

                SELECT
                         MIN(TRANSACTION_DATE)  AS START_DATE   -- 2020-07-31
                        ,MAX(TRANSACTION_DATE)  AS END_DATE     -- 2023-01-30

                FROM
                        BRONZE.TRANSACTION_LINE

            ),

            GENERATE_DATE AS (

                SELECT
                        CAST( RANGE AS DATE ) AS DATE_KEY

                FROM
                        RANGE (
                                 DATE '2020-07-31'
                                ,DATE '2023-01-31'
                                ,INTERVAL 1 DAY
                        )
            )

            SELECT
                    DATE_KEY AS DATE

            FROM
                    GENERATE_DATE

            ORDER BY
                    DATE DESC

            ;

            -- SELECT * FROM DIM_DATES ;

    -- ✅ TRANSACTION LINE

        -- SELECT * FROM TRANSACTION_LINE LIMIT 100 ;
        -- SUMMARIZE TRANSACTION_LINE ;

        -- CREATE OR REPLACE VIEW FACT_INVENTORY
        CREATE OR REPLACE TABLE GOLD.FACT_INVENTORY

        AS

        WITH

        INVENTORY_CLEANUP AS (

            SELECT
                    TRY_CAST( T.transaction_date AS DATE )  AS TRANSACTION_DATE
                    -- ,T.transaction_id                       AS TRANSACTION_ID
                    -- ,T.transaction_line_id                  AS TRANSACTION_LINE_ID
                    -- ,T.transaction_type                     AS TRANSACTION_TYPE
                    -- ,T.type_based_document_number           AS TYPE_BASED_DOCUMENT_NUMBER
                    -- ,T.type_based_document_status           AS TYPE_BASED_DOCUMENT_STATUS
                    ,T.item_id                              AS ITEM_ID
                    ,T.bin_id                               AS BIN_ID
                    ,T.inventory_status_id                  AS INVENTORY_STATUS_ID
                    ,T.location_id                          AS LOCATION_ID
                    ,T.quantity                             AS QUANTITY
                    ,I.ITEM_NAME
                    ,B.BIN_NAME
                    ,N.INVENTORY_STATUS_NAME
                    ,L.LOCATION_NAME
                    ,T.QUANTITY * C.COST                    AS COST

            FROM
                    BRONZE.TRANSACTION_LINE              AS T

                    LEFT JOIN GOLD.DIM_ITEMS             AS I
                        ON T.ITEM_ID = I.ITEM_ID

                    LEFT JOIN GOLD.DIM_BINS              AS B
                        ON T.BIN_ID = B.BIN_ID

                    LEFT JOIN GOLD.DIM_INVENTORY_STATUS  AS N
                        ON T.INVENTORY_STATUS_ID = N.INVENTORY_STATUS_ID

                    LEFT JOIN GOLD.DIM_LOCATIONS         AS L
                        ON T.LOCATION_ID = L.LOCATION_ID

                    LEFT JOIN GOLD.DIM_COSTS             AS C
                        ON  T.ITEM_ID           =   C.ITEM_ID
                        AND T.LOCATION_ID       =   C.LOCATION_ID
                        AND T.TRANSACTION_DATE  >=  C.COST_START_DATE
                        AND T.TRANSACTION_DATE  <   COALESCE( C.COST_END_DATE, '2099-12-31' )

            -- ORDER BY
            --          TRANSACTION_DATE
            --         ,ITEM_ID
            --         ,LOCATION_NAME
            --         ,BIN_NAME
            --         ,INVENTORY_STATUS_NAME

        )
        ,INVENTORY_AGGREGATE AS (

            SELECT
                     TRANSACTION_DATE
                    ,ITEM_ID
                    ,ITEM_NAME
                    ,LOCATION_ID
                    ,LOCATION_NAME
                    ,BIN_ID
                    ,BIN_NAME
                    ,INVENTORY_STATUS_ID
                    ,INVENTORY_STATUS_NAME
                    ,SUM(QUANTITY)      AS QUANTITY
                    ,SUM(COST)          AS COST

            FROM
                    INVENTORY_CLEANUP

            GROUP BY
                    ALL

            -- ORDER BY
            --          TRANSACTION_DATE
            --         ,ITEM_ID
            --         ,LOCATION_NAME
            --         ,BIN_NAME
            --         ,INVENTORY_STATUS_NAME

        )

        ,DAILY_BUILDER AS (

            SELECT
                    *

            FROM
                    GOLD.DIM_DATES

            CROSS JOIN (

                SELECT
                         DISTINCT
                         ITEM_ID
                        -- ,ITEM_NAME
                        ,LOCATION_NAME
                        ,BIN_NAME
                        ,INVENTORY_STATUS_NAME

                FROM
                        INVENTORY_AGGREGATE

            )

        -- ORDER BY
        --          DATE
        --         ,ITEM_ID
        --         ,LOCATION_NAME
        --         ,BIN_NAME
        --         ,INVENTORY_STATUS_NAME

        )

        ,FINAL AS (

            SELECT
                     D.DATE
                    ,D.ITEM_ID
                    -- ,I.ITEM_NAME
                    ,D.LOCATION_NAME
                    ,D.BIN_NAME
                    ,D.INVENTORY_STATUS_NAME
                    ,I.QUANTITY
                    ,I.COST
                    ,SUM( I.QUANTITY )
                    OVER(
                        PARTITION BY D.ITEM_ID, D.LOCATION_NAME, D.BIN_NAME, D.INVENTORY_STATUS_NAME
                        ORDER BY D.DATE

                    )       AS RUNNING_QUANTITY
                    ,SUM( I.COST )
                    OVER(
                        PARTITION BY D.ITEM_ID, D.LOCATION_NAME, D.BIN_NAME, D.INVENTORY_STATUS_NAME
                        ORDER BY D.DATE

                    )       AS RUNNING_COST

            FROM
                    DAILY_BUILDER                   AS D

                    LEFT JOIN INVENTORY_AGGREGATE   AS I
                        ON  D.ITEM_ID       = I.ITEM_ID
                        AND D.LOCATION_NAME = I.LOCATION_NAME
                        AND D.BIN_NAME      = I.BIN_NAME
                        AND D.DATE          = I.TRANSACTION_DATE

            WHERE
                    1 = 1
                    -- AND D.LOCATION_NAME = 'c7a95e433e878be525d03a08d6ab666b'
                    -- AND ITEM_ID = 355576

            -- ORDER BY
            --          D.DATE
            --         ,D.ITEM_ID
            --         ,D.LOCATION_NAME
            --         ,D.BIN_NAME
            --         ,D.INVENTORY_STATUS_NAME

        )

        SELECT * FROM FINAL WHERE RUNNING_COST IS NOT NULL

        ;

        -- SELECT * FROM FACT_INVENTORY ;
