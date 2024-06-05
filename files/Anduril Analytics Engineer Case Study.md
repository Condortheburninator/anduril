# Analytics Engineer Case Study

## Goal
1. Provide you, the candidate, with a representative example of the type of data and  data modeling work expected of the Analytics Engineer

1. Enable Anduril to assess your technical skills in an environment as similar as we’d expect you to work on the job

## Expectations
1. Spend no more than 4 hours on this assignment. We expect this should be able  to be done within that time frame or less.

1. Reach out to psteigler@anduril.com with any questions you encounter as you  work on the case

1. Use resources such as stackoverflow, etc. but cite any external references that  helped you substantially

## Assignment
1. The case study comes with 6 csvs that should be loaded into a database as  tables. These tables represent NetSuite transactional data related to inventory
Tip: BigQuery is an easy to use and low cost option to set up a quick database.

2. Using SQL, model these tables so that you can provide a business user with a  single “inventory daily” table that has: [Date, Location, Bin, Status, Item, Quantity,  Value] where quantity is the total number of units of that item in that  Location+Bin+Status for that Date. Value represents the total monetary value for those items.

3. Do a data quality check – how does the data look? Are there any issues?

4. Answer the following questions:
    a. What is the quantity, and location/bin/status combos of item 355576 on  date 2022-11-21?
    b. What is the total value of item 209372 on Date 2022-06-05?
    c. What is the total value of inventory in Location c7a95e433e878be525d03a08d6ab666b on 2022-01-01?

5. Open Ended: Are there any interesting insights that you’d like to discuss?

## Table List
1. Transaction Line – transaction_date, transaction_id, transaction_line, transaction_type,
type_based_document_number, type_based_document_status, item_id, bin_id, inventory_status_id, location_id,  quantity
1. Item – id, name
1. Location – id, name
1. Costs - effective date, location_id, item_id, cost
1. Bin – id, name
1. Inventory Status – id, name
