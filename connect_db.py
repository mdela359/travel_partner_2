#Author(S): Martin De La Cruz

#Tutorial followed: https://youtu.be/M2NzvnfS-hI

#library imported to connect to database
import psycopg2

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

    insert_script = 'INSERT INTO country (country_id, country_name, ride_share) values (%s, %s, %s)'
    insert_values = (2, 'Jamaica', True)
    cur.execute(insert_script, insert_values)

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
    

