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

response = requests.get(url, params=params)

if response.status_code == 200:
    df = pd.DataFrame(response.json())
    print(tabulate(df.head(5), headers='keys', tablefmt='pretty'))
    
else:
    print(f"Request failed with status code: {response.status_code}")
    print(response.text)
