import requests
import pandas as pd
import json

url = "https://www.travel-advisory.info/api"
params = {"countrycode": "JM"}

response = requests.get(url, params=params)
if response.status_code == 200:
    data = response.json()
    print(data)
    # process the data as needed
else:
    print(f"Error: {response.status_code}")


Url = "https://www.travel-advisory.info/api"

resp = requests.get(url)

dat = resp.json()
print(dat)