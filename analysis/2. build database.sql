

-- CREATE TABLES

    CREATE OR REPLACE TABLE BIN                 AS FROM read_csv_auto('./files/data/bin.csv')                                    ;
    CREATE OR REPLACE TABLE COSTS               AS FROM read_csv_auto('./files/data/costs.csv', types = {'date' : 'VARCHAR'} )   ;
    CREATE OR REPLACE TABLE INVENTORY_STATUS    AS FROM read_csv_auto('./files/data/inventory_status.csv')                       ;
    CREATE OR REPLACE TABLE ITEM                AS FROM read_csv_auto('./files/data/item.csv')                                   ;
    CREATE OR REPLACE TABLE LOCATION            AS FROM read_csv_auto('./files/data/location.csv')                               ;
    CREATE OR REPLACE TABLE TRANSACTION_LINE    AS FROM read_csv_auto('./files/data/transaction_line.csv')                       ;

-- CREATE VIEWS

    -- ✅ BIN

        CREATE OR REPLACE VIEW DIM_BINS

        AS

        SELECT
                 id       AS BIN_ID
                ,name     AS BIN_NAME

        FROM
                BIN

        ;

        -- SELECT * FROM DIM_BINS ;

    -- ✅ COSTS

        -- SELECT * FROM COSTS  ;

        CREATE OR REPLACE VIEW DIM_COSTS

        AS

        WITH

        START_DATE AS (

            SELECT
                     TRY_CAST(STRPTIME(date, '%m/%d/%Y' ) AS DATE)  AS COST_START_DATE
                    ,item_id                                        AS ITEM_ID
                    ,location_id                                    AS LOCATION_ID
                    ,cost                                           AS COST

            FROM
                    COSTS

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

        SELECT
                *

        FROM
                DIM_COSTS

        WHERE
                1 = 1
                AND ITEM_ID = 314
                AND LOCATION_ID = 102

        ;

    -- ✅ INVENTORY_STATUS

        -- SELECT * FROM INVENTORY_STATUS ;

        CREATE OR REPLACE VIEW DIM_INVENTORY_STATUS

        AS

        SELECT
                 id     AS INVENTORY_STATUS_ID
                ,name   AS INVENTORY_STATUS_NAME

        FROM
                INVENTORY_STATUS

        ;

        -- SELECT * FROM DIM_INVENTORY_STATUS ;

    -- ✅ ITEM

        -- SELECT * FROM ITEM ;

        CREATE OR REPLACE VIEW DIM_ITEMS

        AS

        SELECT
                 id     AS ITEM_ID
                ,name   AS ITEM_NAME

        FROM
                ITEM

        ;

        -- SELECT * FROM DIM_ITEMS ;

    -- ✅ LOCATION

        -- SELECT * FROM LOCATION ;

        CREATE OR REPLACE VIEW DIM_LOCATIONS

        AS

        SELECT
                 id     AS LOCATION_ID
                ,name   AS LOCATION_NAME

        FROM
                LOCATION

        ;

        -- SELECT * FROM DIM_LOCATIONS ;

    -- ✅ TRANSACTION LINE

        -- SELECT * FROM TRANSACTION_LINE LIMIT 100 ;
        -- SUMMARIZE TRANSACTION_LINE ;

        CREATE OR REPLACE VIEW FACT_INVENTORY

        AS

        SELECT
                 TRY_CAST( T.transaction_date AS DATE ) AS TRANSACTION_DATE
                ,T.transaction_id                       AS TRANSACTION_ID
                ,T.transaction_line_id                  AS TRANSACTION_LINE_ID
                ,T.transaction_type                     AS TRANSACTION_TYPE
                ,T.type_based_document_number           AS TYPE_BASED_DOCUMENT_NUMBER
                ,T.type_based_document_status           AS TYPE_BASED_DOCUMENT_STATUS
                ,T.item_id                              AS ITEM_ID
                ,T.bin_id                               AS BIN_ID
                ,T.inventory_status_id                  AS INVENTORY_STATUS_ID
                ,T.location_id                          AS LOCATION_ID
                ,T.quantity                             AS QUANTITY
                ,I.ITEM_NAME
                ,B.BIN_NAME
                ,N.INVENTORY_STATUS_NAME
                ,L.LOCATION_NAME

        FROM
                TRANSACTION_LINE                AS T

                LEFT JOIN DIM_ITEMS             AS I
                    ON T.ITEM_ID = I.ITEM_ID

                LEFT JOIN DIM_BINS              AS B
                    ON T.BIN_ID = B.BIN_ID

                LEFT JOIN DIM_INVENTORY_STATUS  AS N
                    ON T.INVENTORY_STATUS_ID = N.INVENTORY_STATUS_ID

                LEFT JOIN DIM_LOCATIONS         AS L
                    ON T.LOCATION_ID = L.LOCATION_ID

                -- LEFT JOIN DIM_COSTS

        ;

        -- SELECT * FROM FACT_INVENTORY ;



