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