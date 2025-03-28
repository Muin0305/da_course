from sqlalchemy import engine, URL
import json

with open('credentials.json') as f:
    credentials = json.load(f)

connection_url = URL.create(
        drivername="postgresql+psycopg2",
        username = credentials['username'],
        password = credentials['password'],
        host = credentials['host'],
        port = credentials['port']
    )

def set_connection(): 
    eng = engine.create_engine(connection_url)
    pg = eng.connect()

    return pg
    



