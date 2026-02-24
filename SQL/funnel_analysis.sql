-- FUNNEL DROP OFF CALCULATION
SELECT
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN wp.pageview_url = '/products' THEN ws.website_session_id END) AS product_views,
    COUNT(DISTINCT CASE WHEN wp.pageview_url = '/cart' THEN ws.website_session_id END) AS cart_views,
    COUNT(DISTINCT CASE WHEN wp.pageview_url = '/shipping' THEN ws.website_session_id END) AS checkout_started,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions_clean ws
LEFT JOIN website_pageviews wp
    ON ws.website_session_id = wp.website_session_id
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id;

-- FUNNEL SEGMENTED BY CHANNEL
WITH funnel AS (
SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%product%' THEN ws.website_session_id END) AS product_views,
    COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%cart%' THEN ws.website_session_id END) AS carts,
    COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%shipping%' THEN ws.website_session_id END) AS shipping,
    COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%billing%' THEN ws.website_session_id END) AS billing,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions_clean ws
LEFT JOIN website_pageviews wp
    ON ws.website_session_id = wp.website_session_id
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.utm_source
)
SELECT *,
    ROUND(orders / sessions * 100,2) AS conversion_rate
FROM funnel
ORDER BY conversion_rate DESC;

-- FUNNEL BY DEVICE TYPE
WITH funnel_device AS (
SELECT
    ws.device_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions_clean ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY ws.device_type
)
SELECT *,
    ROUND(orders / sessions * 100,2) AS conversion_rate
FROM funnel_device;

-- MONTH OVER MONTH FUNNEL TREND
WITH monthly AS (
SELECT
    DATE_FORMAT(ws.created_at,'%Y-%m') AS month,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions_clean ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY month
)
SELECT *,
    ROUND(orders / sessions * 100,2) AS conversion_rate,
    LAG(orders) OVER (ORDER BY month) AS prev_month_orders,
    ROUND(
        (orders - LAG(orders) OVER (ORDER BY month))
        / LAG(orders) OVER (ORDER BY month) * 100
    ,2) AS order_growth_percent
FROM monthly;

-- COHORT RETENTION
WITH first_orders AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM orders
    GROUP BY user_id
)
SELECT 
    DATE_FORMAT(f.first_purchase_date, '%Y-%m') AS cohort_month,
    DATE_FORMAT(o.created_at, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.user_id) AS active_users
FROM orders o
JOIN first_orders f
ON o.user_id = f.user_id
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;
