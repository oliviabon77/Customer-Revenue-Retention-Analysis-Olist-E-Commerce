SELECT
    customer_type,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_order_value,
    ROUND(
        SUM(total_revenue) / COUNT(DISTINCT customer_unique_id), 
        2
    ) AS revenue_per_customer
FROM cohort_base
GROUP BY customer_type
ORDER BY total_revenue DESC;
