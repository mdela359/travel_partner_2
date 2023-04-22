#Tutorial followed: https://youtu.be/M2NzvnfS-hI

#library imported to connect to database
import psycopg2
import numpy as np       
import pandas as pd

def combineDT(ltemp, ldate):            #combine hour with tempature 
    finalL =[]
    for x in range(23):
        finalL.append((ltemp[x],ldate[x]))
    return finalL

def anon(lis,lisTwo):                  # remove random stuff 
    finalL =[]
    finalTwoL=[]
    for x in lis:
        finalL.append(x.replace("]",""))
    for x in lisTwo:
        finalTwoL.append(x.replace("]}}",""))
    return finalL,finalTwoL

# call api
api_key=pd.read_csv('https://api.open-meteo.com/v1/forecast?latitude=18.00&longitude=-76.79&hourly=temperature_2m&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timeformat=iso8601&forecast_days=1&timezone=auto')
# get temp and hrs for weather
date=api_key.columns[10:33] 
# get current date
day= date[0][:10]
#get temps
tempF=api_key.columns[34:]

# create numpy array 
timeL=np.array
for elt in date:
    timeL=np.append(timeL,elt[11:])
#get hrs    
hrs= timeL[1:]

hrs,tempF=anon(hrs,tempF)
complete= combineDT (hrs,tempF)

print(complete)

#variables to collect the database credentials
#find these in pgAdmin 4
hostname = 'localhost'
database = 'travel_partner_db'
username = 'postgres'
pwd = 'travelP'
port_id = 5432
#connection
conn = None
#cursor
cur = None

#by using try, the program will not crash if the connection to the db is unsuccessful
try:
    conn = psycopg2.connect(
        host = hostname,
        dbname = database,
        user = username,
        password = pwd,
        port = port_id)
    
    #cursor
    cur = conn.cursor()

    #insert_script = 'INSERT INTO country (country_id, country_name, ride_share) values (%s, %s, %s)'
    #insert_values = (2, 'Jamaica', True)
    create_hour_temp = 'CREATE TABLE hourly_temperatures (id SERIAL PRIMARY KEY, hour varchar(5), temperature varchar(8))'
    #cur.execute(insert_script, insert_values)
    cur.execute(create_hour_temp)

    for hour, temperature in complete:
        cur.execute("INSERT INTO hourly_temperatures (hour, temperature) VALUES (%s, %s)", (hour, temperature))


    conn.commit()

except Exception as error:
    #print error if any
    print(error)
finally:
    #only close if connected to the database succesfully
    if cur is not None:
        cur.close
    #only close if connected to the databse succesfully
    if conn is not None:
        conn.close
    
