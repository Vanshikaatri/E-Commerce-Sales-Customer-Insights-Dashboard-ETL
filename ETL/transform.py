# src/transform.py
import pandas as pd

# -------------------
# Sessions
# -------------------
def clean_sessions(df):
    df = df.drop_duplicates().copy()
    df['created_at'] = pd.to_datetime(df['created_at'], errors='coerce')
    df['utm_source'] = df['utm_source'].fillna('unknown')
    df['utm_campaign'] = df['utm_campaign'].fillna('unknown')
    df['utm_content'] = df['utm_content'].fillna('unknown')
    df['device_type'] = df['device_type'].fillna('unknown')
    return df

# -------------------
# Pageviews
# -------------------
def clean_pageviews(df, sessions_df):
    df = df.drop_duplicates().copy()
    df['created_at'] = pd.to_datetime(df['created_at'], errors='coerce')
    df = df[df['website_session_id'].isin(sessions_df['website_session_id'])]
    return df

# -------------------
# Orders
# -------------------
def clean_orders(df, sessions_df):
    df = df.drop_duplicates().copy()
    df['created_at'] = pd.to_datetime(df['created_at'], errors='coerce')
    df = df[df['website_session_id'].isin(sessions_df['website_session_id'])]
    return df

# -------------------
# Order Items
# -------------------
def clean_order_items(df, orders_df):
    df = df.drop_duplicates().copy()
    df = df[df['order_id'].isin(orders_df['order_id'])]
    df['profit_usd'] = df['price_usd'] - df['cogs_usd']
    return df

# -------------------
# Refunds
# -------------------
def clean_refunds(df, order_items_df):
    df = df.drop_duplicates().copy()
    df = df[df['order_item_id'].isin(order_items_df['order_item_id'])]
    return df

# -------------------
# Products
# -------------------
def clean_products(df, order_items_df):
    df = df.drop_duplicates().copy()
    df = df[df['product_id'].isin(order_items_df['product_id'])]
    return df