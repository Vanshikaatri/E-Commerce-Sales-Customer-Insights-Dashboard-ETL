# src/extract.py
import pandas as pd
from config import DATA_PATH

def extract_csv(filename):
    """Read a CSV file from the data folder."""
    return pd.read_csv(DATA_PATH + filename)