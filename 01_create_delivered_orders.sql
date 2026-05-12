CREATE OR REPLACE VIEW delivered_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp::TIMESTAMP AS order_date,
    o.order_delivered_customer_date::TIMESTAMP AS delivery_date,
    c.customer_unique_id,
    c.customer_state
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL;
