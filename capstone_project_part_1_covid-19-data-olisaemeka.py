#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# Install the required libraries

pip install pandas psycopg2

# Import the required packages

import pandas as pd

import psycopg2

from sqlalchemy import create_engine


# Load CSV data into a DataFrame

csv_file_path = 'https://drive.google.com/file/d/1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b/view'  

covid_19_data_df = pd.read_csv(csv_file_path)


covid_19_data_df.info()

# Convert 'ObservationDate' column to datetime

covid_19_data_df['ObservationDate'] = pd.to_datetime(covid_19_data_df['ObservationDate'])

# Convert 'LastUpdate' column to datetime

covid_19_data_df['LastUpdate'] = pd.to_datetime(covid_19_data_df['LastUpdate'])

covid_19_data_df

# PostgreSQL database connection details

dbname = 'covid_19_data'
user = 'postgres'
password = 'password'
host = 'localhost'
port = '5432'


# Connect to PostgreSQL

conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)

# Insert data into the 'covid_19_data' table using pandas and SQLAlchemy

table_name = 'covid_19_data'

engine = create_engine(f'postgresql://postgres:password@localhost:5432/covid_19_data')

covid_19_data_df.to_sql(table_name, engine, if_exists='replace', index=False)

# Close the database connection

conn.close()

print("Data loaded successfully into the PostgreSQL database.")

