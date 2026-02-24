-- LOAD DATA INTO TABLES


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/website_sessions.csv'
INTO TABLE website_sessions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(website_session_id,
 created_at,
 user_id,
 is_repeat_session,
 utm_source,
 utm_campaign,
 utm_content,
 device_type,
 http_referer);

SELECT COUNT(*) FROM website_sessions;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/website_pageviews.csv'
INTO TABLE website_pageviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(website_pageview_id,
 created_at,
 website_session_id,
 pageview_url);

SELECT COUNT(*) FROM website_pageviews;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id,
 created_at,
 product_name);

SELECT * FROM products;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
 created_at,
 website_session_id,
 user_id,
 primary_product_id,
 items_purchased,
 price_usd,
 cogs_usd);

SELECT * FROM orders LIMIT 10;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_item_id,
 created_at,
 order_id,
 product_id,
 is_primary_item,
 price_usd,
 cogs_usd);

SELECT COUNT(*) FROM order_items;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/order_item_refunds.csv'
INTO TABLE order_item_refunds
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_item_refund_id,
 created_at,
 order_item_id,
 order_id,
 refund_amount_usd);

SELECT COUNT(*) FROM order_item_refunds;

-- DATA INTEGRITY CHECKS
-- Orders linked to sessions
SELECT COUNT(*) 
FROM orders o
LEFT JOIN website_sessions s
ON o.website_session_id = s.website_session_id
WHERE s.website_session_id IS NULL;

-- Order items linked to orders
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Refunds linked to order_items
SELECT COUNT(*)
FROM order_item_refunds r
LEFT JOIN order_items oi
ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;
