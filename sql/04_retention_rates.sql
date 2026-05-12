WITH new_customers AS (
    SELECT DISTINCT 
        customer_unique_id, 
        first_order_date
    FROM cohort_base
    WHERE customer_type = 'New Customer'
),

repeat_orders AS (
    SELECT
        n.customer_unique_id,
        n.first_order_date,
        DATEDIFF('day', n.first_order_date, MIN(o.order_date)) AS days_to_return
    FROM new_customers n
    JOIN orders_with_revenue o
        ON n.customer_unique_id = o.customer_unique_id
       AND o.order_date > n.first_order_date
    GROUP BY 
        n.customer_unique_id, 
        n.first_order_date
)

SELECT
    COUNT(DISTINCT n.customer_unique_id) AS total_new_customers,

    COUNT(DISTINCT CASE 
        WHEN r.days_to_return <= 30 
        THEN r.customer_unique_id 
    END) AS returned_30d,

    COUNT(DISTINCT CASE 
        WHEN r.days_to_return <= 60 
        THEN r.customer_unique_id 
    END) AS returned_60d,

    COUNT(DISTINCT CASE 
        WHEN r.days_to_return <= 90 
        THEN r.customer_unique_id 
    END) AS returned_90d,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN r.days_to_return <= 30 
            THEN r.customer_unique_id 
        END) * 100.0 / COUNT(DISTINCT n.customer_unique_id), 
        2
    ) AS retention_rate_30d,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN r.days_to_return <= 60 
            THEN r.customer_unique_id 
        END) * 100.0 / COUNT(DISTINCT n.customer_unique_id), 
        2
    ) AS retention_rate_60d,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN r.days_to_return <= 90 
            THEN r.customer_unique_id 
        END) * 100.0 / COUNT(DISTINCT n.customer_unique_id), 
        2
    ) AS retention_rate_90d

FROM new_customers n
LEFT JOIN repeat_orders r 
    ON n.customer_unique_id = r.customer_unique_id;
