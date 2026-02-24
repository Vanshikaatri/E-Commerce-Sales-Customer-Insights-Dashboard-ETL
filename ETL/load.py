# src/load.py
import pandas as pd
import os
from config import OUTPUT_PATH

def save_csv(df, filename):
    """Save cleaned DataFrame to cleaned_data folder."""
    os.makedirs(OUTPUT_PATH, exist_ok=True)
    df.to_csv(OUTPUT_PATH + filename + "_cleaned.csv", index=False)