**Overview**

This document explains the steps, decisions, and considerations made while completing the Sales Data Analysis assignment. The tasks included setting up the environment in Snowflake, ingesting and transforming the sales data, and running SQL queries to answer key business questions.

1. Environment Setup
Decision:
I created a Snowflake database named home_assignment and two schemas: raw (for storing the raw data) and transformed (for storing the transformed data).
Steps:
a. Used Snowflake's worksheet to execute the following SQL commands:

CREATE DATABASE home_assignment;
CREATE SCHEMA raw;
CREATE SCHEMA transformed;

b. A stage my_stage was created for uploading the CSV files.

2. Data Ingestion
Decision:
The orders.csv and customers.csv files were uploaded to the raw_sales_data and raw_customer_data tables, respectively. I used Snowflake’s interface to manually load the CSV data into the tables in the raw schema.
Reasoning:
Manually loading CSV files into Snowflake is efficient when dealing with relatively small datasets and reduces the complexity of using dbt or other ETL tools.

3. Data Transformation
Decision:
I created a transformed table, transformed_sales_data, by extracting the year, month, and day from the order_date field and calculating the total_sales_amount for each order.
Reasoning:
Extracting these date components simplifies the process of filtering and grouping data by time periods.
Calculating the total sales amount for each order was necessary to answer the business questions related to revenue and order value.

SQL Query:

CREATE OR REPLACE TABLE HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data AS
SELECT
  order_id,
  product_id,
  customer_id,
  quantity,
  price,
  quantity * price AS total_sales_amount,
  EXTRACT(YEAR FROM order_date) AS order_year,
  EXTRACT(MONTH FROM order_date) AS order_month,
  EXTRACT(DAY FROM order_date) AS order_day
FROM HOME_ASSIGNMENT.RAW.orders_data;

4. Analysis Queries
Decision:
I wrote separate SQL queries to answer each of the four business questions. Each query was saved in a separate .sql file under the queries folder, per the instructions.
Reasoning:
Splitting the queries into separate files ensures clarity and modularity, making it easier to execute each query independently and debug if needed.

Queries and Files:

i. Top 5 Products by Total Sales in 2023:

- File: top_5_products.sql
- Purpose: Identify the top 5 products by total sales amount.
- Query:

SELECT product_id, SUM(total_sales_amount) AS total_sales
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 5;


ii. Top 5 Customers by Total Sales in 2023:

- File: top_5_customers.sql
- Purpose: Identify the top 5 customers by total sales amount.
- Query:

SELECT customer_id, SUM(total_sales_amount) AS total_sales
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

iii. Average Order Value for Each Month in 2023:

- File: avg_order_value.sql
- Purpose: Calculate the average order value for each month in 2023.
- Query:

SELECT order_month, AVG(total_sales_amount) AS avg_order_value
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY order_month
ORDER BY order_month;

iv. Customer with Highest Order Volume in October 2023:

- File: highest_order_volume_october.sql
- Purpose: Identify the customer with the highest order volume in October 2023.
- Query:

SELECT customer_id, COUNT(order_id) AS order_volume
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023 AND order_month = 10
GROUP BY customer_id
ORDER BY order_volume DESC
LIMIT 1;

5. Challenges and Solutions
Challenge:
Initially, I encountered difficulty with file upload functionality in Snowflake due to file format and size issues.
Solution:
I converted the files from .xlsx to .csv to ensure compatibility and successfully uploaded them to the Snowflake stage.

6. Final Submission
All SQL queries and scripts were organized into separate files inside a queries folder, following the guidelines.
The overall project files include:
README.md
DECISIONS.md
The queries folder with all relevant SQL files.