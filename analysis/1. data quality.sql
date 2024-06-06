

-- duplicate item names
SUMMARIZE DIM_ITEMS ;

WITH

DUPE_ITEMS AS (

    SELECT
             ITEM_NAME
            ,COUNT(*)       AS ITEM_COUNT

    FROM
            DIM_ITEMS

    GROUP BY
            ITEM_NAME

    HAVING
            COUNT(*) > 1

    -- ;

),

DUPE_ITEMS2 AS (

    SELECT
            *

    FROM
            DIM_ITEMS

    WHERE
            1 = 1
            AND ITEM_NAME IN ( SELECT ITEM_NAME FROM DUPE_ITEMS )

    ORDER BY
             ITEM_NAME
            ,ITEM_ID

)

SELECT
         ITEM_ID
        ,TRANSACTION_DATE
        ,QUANTITY

FROM
        TRANSACTION_LINE

WHERE
        1 = 1
        -- AND ITEM_ID IN (444086, 444087)
        -- AND ITEM_ID = 444086
        AND ITEM_ID IN ( SELECT ITEM_ID FROM DUPE_ITEMS2 )

ORDER BY
        ITEM_ID

;


-- missing costs

SELECT
         DISTINCT T.ITEM_ID
        -- ,C.COST

FROM
        TRANSACTION_LINE        AS T

        LEFT JOIN COSTS         AS C
            ON  T.ITEM_ID       = C.ITEM_ID
            AND T.LOCATION_ID   = C.LOCATION_ID

WHERE
        1 = 1
        AND C.COST IS NULL

ORDER BY
        T.ITEM_ID

;

SELECT
        *

FROM
        COSTS       AS C


WHERE
        1 = 1
        AND ITEM_ID = 12154
        AND ITEM_ID IN (

             12154
            ,169619
            ,252089
            ,282175
            ,366929
            ,400579
            ,442167
            ,442168
            ,442171
            ,442172
            ,442173
            ,442174
        )

ORDER BY
         ITEM_ID
        ,LOCATION_ID
        ,DATE

;

SELECT
        TRANSACTION_DATE
        ,ITEM_ID
        ,ITEM_NAME
        ,TYPE_BASED_DOCUMENT_STATUS
        ,TYPE_BASED_DOCUMENT_NUMBER
        ,BIN_NAME
        ,LOCATION_ID
        ,LOCATION_NAME
        ,COST

FROM
        FACT_INVENTORY

WHERE
        1 = 1
        AND ITEM_ID IN (

             12154
            ,169619
            ,252089
            ,282175
            ,366929
            ,400579
            ,442167
            ,442168
            ,442171
            ,442172
            ,442173
            ,442174
        )

ORDER BY
         ITEM_ID
        ,LOCATION_ID
        ,TRANSACTION_DATE
;



-- WEIRD COSTS IN COST TABLE

SELECT
         SUM(
            CASE
                WHEN DAYOFMONTH(COST_START_DATE) = 1
                THEN 1
                ELSE 0
             END
        )           AS FIRST_DAY_COUNT
        ,SUM(
            CASE
                WHEN DAYOFMONTH(COST_START_DATE) != 1
                THEN 1
                ELSE 0
             END
        )           AS NOT_FIRST_DAY
        ,FIRST_DAY_COUNT / COUNT(*)

FROM
        DIM_COSTS

WHERE
        1 = 1
        -- AND ITEM_ID = 314
        -- AND DAYOFMONTH(COST_START_DATE) != 1
        -- AND DAYOFMONTH(date) != 1
        -- AND EXTRACT(DAY FROM date) != 1

-- ORDER BY
        --  ITEM_ID
        -- ,LOCATION_ID
        -- ,date

;