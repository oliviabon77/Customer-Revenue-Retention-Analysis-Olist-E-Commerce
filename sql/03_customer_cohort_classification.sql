CREATE OR REPLACE TABLE cohort_base AS
SELECT
    o.order_id,
    o.customer_unique_id,
    o.order_date,
    o.total_revenue,
    c.first_order_date,
    DATEDIFF('day', c.first_order_date, o.order_date) AS days_since_first_order,
    CASE
        WHEN DATEDIFF('day', c.first_order_date, o.order_date) = 0
        THEN 'New Customer'
        ELSE 'Returning Customer'
    END AS customer_type
FROM orders_with_revenue o
JOIN (
    SELECT 
        customer_unique_id, 
        MIN(order_date) AS first_order_date
    FROM orders_with_revenue
    GROUP BY customer_unique_id
) c 
    ON o.customer_unique_id = c.customer_unique_id;
