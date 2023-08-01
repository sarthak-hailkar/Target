CREATE VIEW vw_order_details AS
SELECT
o.order_id,
o.order_date,
c.customer_id,
c.customer_name,
o.product_id,
o.quantity,
o.unit_price,
o.quantity * o.unit_price AS order_total,
CASE
WHEN o.status = 'A' THEN 'Active'
WHEN o.status = 'P' THEN 'Pending'
WHEN o.status = 'C' THEN 'Completed'
ELSE 'Unknown'
END AS order_status
FROM
orders o
JOIN
customers c ON o.customer_id = c.customer_id;
