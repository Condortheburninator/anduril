

-- CREATE TABLES

    -- CREATE OR REPLACE TABLE BIN                 AS FROM read_csv_auto('./files/data/bin.csv')               ;
    -- CREATE OR REPLACE TABLE COSTS               AS FROM read_csv_auto('./files/data/costs.csv')             ;
    -- CREATE OR REPLACE TABLE INVENTORY_STATUS    AS FROM read_csv_auto('./files/data/inventory_status.csv')  ;
    -- CREATE OR REPLACE TABLE ITEM                AS FROM read_csv_auto('./files/data/item.csv')              ;
    -- CREATE OR REPLACE TABLE LOCATION            AS FROM read_csv_auto('./files/data/location.csv')          ;
    -- CREATE OR REPLACE TABLE TRANSACTION_LINE    AS FROM read_csv_auto('./files/data/transaction_line.csv')  ;

-- CREATE VIEWS

    -- BIN

    CREATE OR REPLACE VIEW DIM_BIN

    AS

    SELECT
             id        AS BIN_ID
            ,name     AS BIN_NAME

    FROM
            BIN

    ;

    -- INVENTORY_STATUS

    -- SELECT * FROM INVENTORY_STATUS ;

    CREATE OR REPLACE VIEW DIM_INVENTORY_STATUS

    AS

    SELECT
             id     AS INVENTORY_STATUS_ID
            ,name   AS INVENTORY_STATUS_NAME

    FROM
            INVENTORY_STATUS

    ;

-- profile
SUMMARIZE bin                   ;
SUMMARIZE costs                 ;
SUMMARIZE inventory_status      ;
SUMMARIZE item                  ;
SUMMARIZE location              ;
SUMMARIZE transaction_line      ;

-- SELECT
--         *

-- FROM
--         TRANSACTION_LINE


-- ;


SHOW SCHEMA ;