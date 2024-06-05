

```
  ___   _   _______ _   _______ _____ _
 / _ \ | \ | |  _  \ | | | ___ \_   _| |
/ /_\ \|  \| | | | | | | | |_/ / | | | |
|  _  || . ` | | | | | | |    /  | | | |
| | | || |\  | |/ /| |_| | |\ \ _| |_| |____
\_| |_/\_| \_/___/  \___/\_| \_|\___/\_____/

```
`CONNER FERGUSON TAKE HOME ASSESSMENT`

## Overview

I've been looking for an excuse to try out duckdb for a while now.

---

## 🎯 Approach

1. load data into warehouse un-transformed
1. given that the data sets are fairly simple, build `VIEWS` on top of the RAW layer to handle for simple transformations
    1. convert `transaction_date` from a datetime to a date
1. build a fact table for inventory
1. run analysis


---

## Next Steps
- model the data in dbt

---

## :book: Bibliography

- [DuckDB Tutorial For Beginners](https://www.youtube.com/watch?v=ZX5FdqzGT1E)
- [DuckDB Tutorial - DuckDB course for beginners](https://www.youtube.com/watch?v=AjsB6lM2-zw)
- [Ingesting #csv file from #github into #duckdb](https://www.youtube.com/shorts/49p4HyNFniE)