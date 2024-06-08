

-- QUESTION 4-A

    SELECT
             DATE
            ,ITEM_ID                    AS ITEM
            ,INVENTORY_STATUS_NAME      AS STATUS
            ,LOCATION_NAME              AS LOCATION
            ,BIN_NAME                   AS BIN
            ,SUM(RUNNING_QUANTITY)      AS QUANTITY
            ,SUM(RUNNING_COST)          AS VALUE

    FROM
            FACT_INVENTORY

    WHERE
            1 = 1
            AND ITEM_ID     = 355576
            AND DATE        = '2022-11-21'

    GROUP BY
            ALL

    ORDER BY
             ITEM_ID
            ,LOCATION_NAME
            ,BIN_NAME

    ;


-- QUESTION 4-B

    SELECT
             SUM(RUNNING_COST)      AS VALUE

    FROM
            FACT_INVENTORY

    WHERE
            1 = 1
            AND ITEM_ID = 209372
            AND DATE    = '2022-06-05'

    ;

-- QUESTION 4-C

    SELECT
             SUM(RUNNING_COST)  AS VALUE

    FROM
            FACT_INVENTORY

    WHERE
            1 = 1
            AND LOCATION_NAME   = 'c7a95e433e878be525d03a08d6ab666b'
            AND DATE            = '2022-01-01'

    ;

j