-- MONTHLY TRAFFIC & ORDERS
SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY yr, mo
ORDER BY yr, mo;

-- CONVERSION RATE
SELECT 
    DATE_FORMAT(ws.created_at, '%Y-%m') AS month,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100, 2) AS conversion_rate_pct
FROM website_sessions ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY month
ORDER BY month;

-- REVENUE & REVENUE PER SESSION
SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(o.price_usd),2) AS revenue,
    ROUND(SUM(o.price_usd)/COUNT(DISTINCT ws.website_session_id),2) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY yr, mo
ORDER BY yr, mo;

-- AOV
SELECT 
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    ROUND(SUM(price_usd)/COUNT(order_id),2) AS avg_order_value
FROM orders
GROUP BY month
ORDER BY month;

-- REFUND IMPACT
SELECT 
    ROUND(SUM(refund_amount_usd),2) AS total_refunds,
    ROUND(SUM(refund_amount_usd) * 100 /
         (SELECT SUM(price_usd) FROM orders),2) AS refund_pct_of_revenue
FROM order_item_refunds;

-- REPEATS VS NEW USERS
SELECT 
    is_repeat_session,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id) /
          COUNT(DISTINCT ws.website_session_id) * 100,2) AS conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY is_repeat_session;

-- MONTHLY KPIS TABLE
CREATE TABLE monthly_kpis AS
SELECT 
    DATE_FORMAT(ws.created_at, '%Y-%m') AS month,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(o.price_usd),2) AS revenue,
    ROUND(COUNT(DISTINCT o.order_id) /
          COUNT(DISTINCT ws.website_session_id) * 100,2) AS conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY month;

-- DEVICE TYPE ANALYSIS
SELECT 
    device_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id) /
          COUNT(DISTINCT ws.website_session_id) * 100,2) AS conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders o
ON ws.website_session_id = o.website_session_id
GROUP BY device_type;

-- RUNNING REVENUE
SELECT 
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_revenue
FROM (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        ROUND(SUM(price_usd),2) AS revenue
    FROM orders
    GROUP BY month
) t
ORDER BY month;

-- CHANNEL RANKING BY REVENUE
SELECT 
    utm_source,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM (
    SELECT 
        ws.utm_source,
        ROUND(SUM(o.price_usd),2) AS revenue
    FROM website_sessions_clean ws
    JOIN orders o
    ON ws.website_session_id = o.website_session_id
    GROUP BY ws.utm_source
) t;

-- CONVERSION TREND WITH MOM CHANGE
SELECT 
    month,
    conversion_rate,
    ROUND(
        conversion_rate -
        LAG(conversion_rate) OVER (ORDER BY month),
    2) AS mom_change
FROM (
    SELECT 
        DATE_FORMAT(ws.created_at,'%Y-%m') AS month,
        ROUND(COUNT(DISTINCT o.order_id) /
              COUNT(DISTINCT ws.website_session_id) * 100,2) AS conversion_rate
    FROM website_sessions_clean ws
    LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
    GROUP BY month
) t;
