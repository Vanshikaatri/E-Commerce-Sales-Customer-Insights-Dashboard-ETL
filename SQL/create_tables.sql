-- CREATE DATABASE
CREATE DATABASE fuzzy_factory_analytics;
USE fuzzy_factory_analytics;

-- CREATE TABLES
CREATE TABLE website_sessions (
    website_session_id INT PRIMARY KEY,
    created_at DATETIME,
    utm_source VARCHAR(50),
    utm_campaign VARCHAR(50),
    utm_content VARCHAR(50),
    device_type VARCHAR(20)
);

ALTER TABLE website_sessions
ADD COLUMN user_id INT,
ADD COLUMN is_repeat_session INT;

CREATE TABLE website_pageviews (
    website_pageview_id INT PRIMARY KEY,
    website_session_id INT,
    created_at DATETIME,
    pageview_url VARCHAR(255),
    FOREIGN KEY (website_session_id) 
        REFERENCES website_sessions(website_session_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    website_session_id INT,
    created_at DATETIME,
    primary_product_id INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2),
    FOREIGN KEY (website_session_id) 
        REFERENCES website_sessions(website_session_id)
);

ALTER TABLE orders
ADD COLUMN user_id INT,
ADD COLUMN items_purchased INT;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2),
    FOREIGN KEY (order_id) 
        REFERENCES orders(order_id)
);

ALTER TABLE order_items
ADD COLUMN is_primary_item INT,
ADD COLUMN created_at DATETIME;

CREATE TABLE order_item_refunds (
    order_item_refund_id INT,
    order_item_id INT,
    order_id INT,
    refund_amount_usd DECIMAL(10,2),
    created_at DATETIME,
    FOREIGN KEY (order_item_id) 
        REFERENCES order_items(order_item_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    created_at DATETIME
);

-- INDEXES FOR PERFORMANCE
CREATE INDEX idx_sessions_date 
ON website_sessions(created_at);

CREATE INDEX idx_sessions_source 
ON website_sessions(utm_source);

CREATE INDEX idx_orders_session 
ON orders(website_session_id);
