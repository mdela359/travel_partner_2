#!/usr/bin/env python
# coding: utf-8

# In[1]:


#Author(s): Jevaughn Stewart

import requests
import pandas as pd
import json


url = "https://api.apilayer.com/exchangerates_data/convert?to=USD&from=EUR&amount=100"

payload = {}
key=pd.read_csv("key.csv")
headers= {
    
  "apikey": key.columns[0]
}

response = requests.request("GET", url, headers=headers, data = payload)

status_code = response.status_code
result = response.json()

result["result"]
