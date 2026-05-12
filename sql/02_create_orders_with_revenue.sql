CREATE OR REPLACE VIEW order_revenue AS
SELECT 
    order_id, 
    SUM(payment_value) AS total_revenue
FROM payments
GROUP BY order_id;

CREATE OR REPLACE VIEW orders_with_revenue AS
SELECT 
    d.*, 
    r.total_revenue
FROM delivered_orders d
LEFT JOIN order_revenue r 
    ON d.order_id = r.order_id
WHERE r.total_revenue IS NOT NULL
  AND r.total_revenue > 0;
