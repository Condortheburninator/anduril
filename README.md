

```
  ___   _   _______ _   _______ _____ _
 / _ \ | \ | |  _  \ | | | ___ \_   _| |
/ /_\ \|  \| | | | | | | | |_/ / | | | |
|  _  || . ` | | | | | | |    /  | | | |
| | | || |\  | |/ /| |_| | |\ \ _| |_| |____
\_| |_/\_| \_/___/  \___/\_| \_|\___/\_____/

```
`CONNER FERGUSON TAKE HOME ASSESSMENT`


---

## 🎯 Approach

1. align on data warehouse --> :duck: duckdb
1. load data into warehouse (raw)
1. data quality review
1. given that the data sets are fairly simple, build `VIEWS` on top of the RAW layer to handle for simple transformations
    1. convert `transaction_date` from a datetime to a date
    1. `ITEM.name` --> `ITEM.ITEM_NAME`
1. build a fact table for inventory
    1. JOIN dimensions VIEWS to it
1. modify FACT_INVENTORY
    1. calendar table
    1. running total inventory table
1. answer questions


---

## Next Steps
- model the data in dbt
- set up daily (nightly) snapshots for inventory

---

## :book: Bibliography

- [DuckDB Tutorial For Beginners](https://www.youtube.com/watch?v=ZX5FdqzGT1E)
- [DuckDB Tutorial - DuckDB course for beginners](https://www.youtube.com/watch?v=AjsB6lM2-zw)
- [Ingesting #csv file from #github into #duckdb](https://www.youtube.com/shorts/49p4HyNFniE)