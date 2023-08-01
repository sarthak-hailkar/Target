CREATE VIEW vw_recent_sales AS
SELECT product_id, product_name, quantity, sales_date
FROM sales_data
WHERE sales_date >= CURRENT_DATE - INTERVAL '30' DAY;
