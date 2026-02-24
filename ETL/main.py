# main.py
from src.extract import extract_csv
from src.transform import (
    clean_sessions, clean_pageviews, clean_orders,
    clean_order_items, clean_refunds, clean_products
)
from src.load import save_csv

print("ETL Pipeline Started...")

# ------------------- Extract -------------------
sessions = extract_csv("website_sessions.csv")
pageviews = extract_csv("website_pageviews.csv")
orders = extract_csv("orders.csv")
order_items = extract_csv("order_items.csv")
refunds = extract_csv("order_item_refunds.csv")
products = extract_csv("products.csv")

# ------------------- Transform -------------------
sessions = clean_sessions(sessions)
pageviews = clean_pageviews(pageviews, sessions)
orders = clean_orders(orders, sessions)
order_items = clean_order_items(order_items, orders)
refunds = clean_refunds(refunds, order_items)
products = clean_products(products, order_items)

# ------------------- Load -------------------
save_csv(sessions, "sessions")
save_csv(pageviews, "pageviews")
save_csv(orders, "orders")
save_csv(order_items, "order_items")
save_csv(refunds, "refunds")
save_csv(products, "products")

print("ETL Pipeline Completed Successfully!")