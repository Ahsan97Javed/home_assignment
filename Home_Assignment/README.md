**Home Assignment**
Assignment Overview:
This assignment demonstrates data ingestion, transformation, and analysis of sales data using Snowflake. The tasks include setting up the environment, transforming raw data, and running queries to answer key business questions. Each task is broken down into separate SQL files, making the process easy to follow and execute.

Folder Structure:
.
├── queries/
│   ├── setup_environment.sql
│   ├── data_transformation.sql
│   ├── top_5_products.sql
│   ├── top_5_customers.sql
│   ├── avg_order_value.sql
│   ├── highest_order_volume_october.sql
├── README.md
├── DECISIONS.md

1. setup_environment.sql
This script sets up the necessary Snowflake environment. It creates:

-A new database called home_assignment.
-Two schemas: raw for raw data and transformed for the processed data.
-A stage in Snowflake for handling file uploads.

To run this script:
USE DATABASE home_assignment;

CREATE SCHEMA raw;
CREATE SCHEMA transformed;

CREATE OR REPLACE STAGE my_stage;


2. data_transformation.sql
This script transforms the raw sales data. It extracts useful components like year, month, and day from the order_date and calculates the total sales amount for each order.

To run this script:
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


3. top_5_products.sql
This query answers the business question: What are the top 5 products by total sales amount in 2023?

To run this query:
SELECT product_id, SUM(total_sales_amount) AS total_sales
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 5;


4. top_5_customers.sql
This query answers the business question: What are the names of the top 5 customers by total sales amount in 2023?

To run this query:
SELECT customer_id, SUM(total_sales_amount) AS total_sales
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


5. avg_order_value.sql
This query answers the business question: What is the average order value for each month in 2023?

To run this query:
SELECT order_month, AVG(total_sales_amount) AS avg_order_value
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY order_month
ORDER BY order_month;


6. highest_order_volume_october.sql
This query answers the business question: Which customer had the highest order volume in the month of October 2023?

To run this query:
SELECT customer_id, COUNT(order_id) AS order_volume
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023 AND order_month = 10
GROUP BY customer_id
ORDER BY order_volume DESC
LIMIT 1;


**How to Run the Project**
-Prerequisites
1. Snowflake: You need a Snowflake account to execute the SQL queries. 
2. CSV Files: The raw data should already be uploaded as raw_sales_data and raw_customer_data in the raw schema.

-Steps

1. Set Up Environment:

- Run the setup_environment.sql file to create the database and schemas.

2. Load and Transform Data:

- Ensure the orders.csv and customers.csv files are loaded into the raw_sales_data and raw_customer_data tables, respectively.
- Run the data_transformation.sql file to transform the raw sales data.

3. Run Analysis Queries:

- Run each of the provided .sql files in the queries folder to answer the business questions.
- The files include:
	- top_5_products.sql
	- top_5_customers.sql
	- avg_order_value.sql
	- highest_order_volume_october.sql