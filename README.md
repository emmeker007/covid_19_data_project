# covid_19_data_project
I devised a python script to download the data from the specified URL and load it into the specified PostgreSQL database.
COVID-19 Data Download, Data Type Modification, and Loading to PostgreSQL Database

This README provides instructions on how to use the code in this repository to download
COVID-19 data from a Google Drive link, modify two of the data types of the columns, and load
the data into a PostgreSQL database.

-Prerequisites
Python 3.8 or higher
Pandas 
psycopg2

# Import the required packages

import pandas as pd

import psycopg2

from sqlalchemy import create_engine

-Instructions
Clone the repository to your local machine.
Create a new PostgreSQL database and user.
Update the file_url and postgresql_conn_string variables in the download_and_load_covid_19_data.py 
file with the Google Drive link to the COVID-19 data file and the connection string for your PostgreSQL
database, respectively.

Run the download_and_load_covid_19_data.py script.
The download_and_load_covid_19_data.py script will download the COVID-19 data file from Google Drive, 
modify the data types of the columns, and load the data into the PostgreSQL database.

-Operational Guidelines
The download_and_load_covid_19_data.py script can be run as many times as needed to download the COVID-19 
data file and load it into the PostgreSQL database.
The script will not overwrite any existing data in the PostgreSQL database.
The script can be modified to load the data into a different PostgreSQL database or to modify the data types
of different columns.

Contact Information
If you have any questions about the code or the data loading process, please contact me 
Andy Olisaemeka a.k.a Emmeker007 at [emmeker@gmail.com].
