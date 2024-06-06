

SELECT
         TRANSACTION_DATE
        ,LOCATION_NAME
        ,INVENTORY_STATUS_NAME
        ,BIN_NAME
        ,ITEM_ID
        ,SUM(QUANTITY)  AS QUANTITY
        ,SUM(COST)      AS COST

FROM
        FACT_INVENTORY

WHERE
        1 = 1
        -- AND ITEM_ID = 355576
        -- AND TRANSACTION_DATE <= '2022-11-21'

GROUP BY
        ALL

ORDER BY
         TRANSACTION_DATE
        ,ITEM_ID
        ,LOCATION_NAME

;



SELECT
        -- LOCATION_NAME
        -- ,INVENTORY_STATUS_NAME
        -- ,BIN_NAME
         ITEM_ID
        ,SUM(QUANTITY)  AS QUANTITY
        ,SUM(COST)      AS COST

FROM
        FACT_INVENTORY

WHERE
        1 = 1
        AND ITEM_ID             = 355576
        AND TRANSACTION_DATE    <= '2022-06-05'

GROUP BY
        ALL

-- ORDER BY
--          TRANSACTION_DATE
--         ,ITEM_ID
--         ,LOCATION_ID

;



-- QUESTION 4-A

    SELECT
            --  TRANSACTION_DATE
            ITEM_ID                AS ITEM
            ,INVENTORY_STATUS_NAME  AS STATUS
            ,LOCATION_NAME          AS LOCATION
            ,BIN_NAME               AS BIN
            ,SUM(QUANTITY)          AS QUANTITY
            ,SUM(COST)              AS VALUE

    FROM
            FACT_INVENTORY

    WHERE
            1 = 1
            AND ITEM_ID = 355576
            AND TRANSACTION_DATE <= '2022-11-21'

    GROUP BY
            ALL

    ORDER BY
            --  TRANSACTION_DATE
            ITEM_ID
            ,LOCATION_NAME
            ,BIN_NAME

    ;


-- QUESTION 4-B

    SELECT
             ITEM_ID
            -- ,SUM(QUANTITY)  AS QUANTITY
            ,SUM(COST)      AS VALUE

    FROM
            FACT_INVENTORY

    WHERE
            1 = 1
            AND ITEM_ID             = 209372
            AND TRANSACTION_DATE    <= '2022-06-05'

    GROUP BY
            ALL

    ;

SELECT
        --  ITEM_ID
        -- ,SUM(COST)
         SUM(COST)  AS VALUE

FROM
        FACT_INVENTORY

WHERE
        1 = 1
        AND LOCATION_NAME           = 'c7a95e433e878be525d03a08d6ab666b'
        AND TRANSACTION_DATE        <= '2022-01-01'

-- GROUP BY
--         ALL

-- ORDER BY
        -- ITEM_ID

;


