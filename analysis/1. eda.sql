

-- profile
    SUMMARIZE bin                   ;
    SUMMARIZE costs                 ;
    SUMMARIZE inventory_status      ;
    SUMMARIZE item                  ;
    SUMMARIZE location              ;
    SUMMARIZE transaction_line      ;

--

SELECT
          name
         ,COUNT(*)
        -- ,name

FROM
        ITEM

WHERE
        1 = 1

GROUP BY
        name

HAVING
        COUNT(*) > 1

;

SELECT * FROM ITEM WHERE name = '1b3706b2e0fdfe747a49895c04208436' ORDER by id;