SELECT customer_id, SUM(total_sales_amount) AS total_sales
FROM HOME_ASSIGNMENT.TRANSFORMED.transformed_sales_data
WHERE order_year = 2023
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;