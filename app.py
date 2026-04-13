import requests
import pandas as pd
from tabulate import tabulate

url = "https://rconnect.cefas.co.uk/onebenthic_api_1/API-1_with_filters"

params = [
    ("in_year", 2020),
    ("in_year", 2021),
    ("in_sieve_size_mm", 1),
    ("in_sieve_size_mm", 5),
]

response = requests.get(url, params=params, verify=False)

if response.status_code == 200:
    df = pd.DataFrame(response.json())    
    df_preview = df.iloc[:5, :7]

    # Print in tabular format
    print(tabulate(df_preview, headers='keys', tablefmt='grid'))
else:
    print(f"Error fetching data: {response.status_code}")
