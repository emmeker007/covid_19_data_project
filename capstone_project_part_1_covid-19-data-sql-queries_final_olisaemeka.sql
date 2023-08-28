#1. Total Number of Records in the dataset

SELECT * FROM covid_19_data;


#2.	a. (i) Retrieve the cumulative counts of confirmed cases

SELECT "Country", SUM("Confirmed") AS cumulative_confirmed
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY "Country";

#(ii) Retrieve the cumulative counts of deceased cases

SELECT "Country", SUM("Deaths") AS cumulative_deceased
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY "Country";

#(iii) Retrieve the cumulative counts of recovered cases

SELECT "Country", SUM("Recovered") AS cumulative_recoveries
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY "cumulative_recoveries";

# b. Extract the aggregate counts of confirmed, deceased, and recovered cases
# for the first quarter of each observation year.

SELECT EXTRACT(YEAR FROM "ObservationDate") AS observation_year,
       SUM("Confirmed") AS total_confirmed,
       SUM("Deaths") AS total_deceased,
       SUM("Recovered") AS total_recovered
FROM "covid_19_data"
WHERE EXTRACT(MONTH FROM "ObservationDate") BETWEEN 1 AND 3
GROUP BY observation_year
ORDER BY observation_year;

# c. Formulate a comprehensive summary encompassing the following for each country:
#Total confirmed cases
#Total deaths
#Total recoveries

SELECT "Country",
       SUM("Confirmed") AS total_confirmed,
       SUM("Deaths") AS total_deaths,
       SUM("Recovered") AS total_recoveries
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY total_confirmed DESC;

# d. Determine the percentage increase in the number of death cases from 2019 to 2020.

SELECT ((total_deaths_2020 - total_deaths_2019) / total_deaths_2019) * 100 AS death_increase_percentage
FROM (
    SELECT
        SUM(CASE WHEN EXTRACT(YEAR FROM "ObservationDate") = 2019 THEN "Deaths" ELSE 0 END) AS total_deaths_2019,
        SUM(CASE WHEN EXTRACT(YEAR FROM "ObservationDate") = 2020 THEN "Deaths" ELSE 0 END) AS total_deaths_2020
    FROM "covid_19_data"
) subquery;


# e. Compile data for the top 5 countries with the highest number of confirmed cases.

SELECT "Country",
       SUM("Confirmed") AS total_confirmed,
       SUM("Deaths") AS total_deaths,
       SUM("Recovered") AS total_recoveries
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY total_confirmed DESC
LIMIT 5;


# f. Calculate the net change (increase or decrease) in confirmed cases on a monthly basis over 
# the two-year period.

SELECT
    EXTRACT(YEAR FROM "ObservationDate") AS year,
    EXTRACT(MONTH FROM "ObservationDate") AS month,
    SUM("Confirmed") - LAG(SUM("Confirmed"), 1, 0) OVER (ORDER BY EXTRACT(YEAR FROM "ObservationDate"),
	EXTRACT(MONTH FROM "ObservationDate")) AS net_change
FROM "covid_19_data"
WHERE EXTRACT(YEAR FROM "ObservationDate") BETWEEN 2019 AND 2020
GROUP BY year, month
ORDER BY year, month;


#My own questions for insights
#1. Yearly Average Cases, Recoveries and Deaths:

SELECT
    DATE_TRUNC('YEAR', "ObservationDate") AS year_start,
    AVG("Confirmed") AS avg_yearly_cases,
    AVG("Deaths") AS avg_yearly_deaths,
    AVG("Recovered") AS avg_yearly_recoveries
	FROM "covid_19_data"
GROUP BY year_start
ORDER BY year_start;


#2. Quarterly Average Cases, Recoveries and Deaths:

SELECT
    EXTRACT(QUARTER FROM "ObservationDate") AS quarter,
    EXTRACT(YEAR FROM "ObservationDate") AS year,
    AVG("Confirmed") AS avg_cases,
    AVG("Recovered") AS avg_recoveries,
    AVG("Deaths") AS avg_deaths
FROM
    "covid_19_data"
GROUP BY
    quarter, year
ORDER BY
    year, quarter;


#3. Total number of Cases, Deaths, and Recoveries by Country

SELECT "Country",
       SUM("Confirmed") AS total_cases,
       SUM("Deaths") AS total_deaths,
       SUM("Recovered") AS total_recoveries
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY total_cases
DESC;

#4. Total number of Cases, Deaths, and Recoveries in the dataset

SELECT
    SUM("Confirmed") AS total_confirmed_cases,
    SUM("Deaths") AS total_deaths,
    SUM("Recovered") AS total_recovered
FROM "covid_19_data";


#5. Top 10 Countries with the highest cases

SELECT
    "Country",
    MAX("Confirmed") AS max_confirmed_cases
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY max_confirmed_cases DESC
LIMIT 10;


#6. Death-rate by Country

SELECT "Country",
    (SUM("Deaths")::float / NULLIF(SUM("Confirmed"), 0)) * 100 AS death_rate
FROM "covid_19_data"
GROUP BY "Country"
ORDER BY death_rate
DESC LIMIT 10;

#7. Countries with the Highest Recovery Rates:

SELECT
    "Country",
    (SUM("Recovered")::float / NULLIF(SUM("Confirmed"), 0)) * 100 AS recovery_rate
FROM "covid_19_data"
GROUP BY "Country"
HAVING SUM("Confirmed") > 1000
ORDER BY recovery_rate DESC;


#8. Monthly Average Cases, Recoveries and Deaths:

SELECT
    DATE_TRUNC('MONTH', "ObservationDate") AS month_start,
    AVG("Confirmed") AS avg_monthly_cases,
    AVG("Deaths") AS avg_monthly_deaths,
    AVG("Recovered") AS avg_monthly_recoveries
	FROM "covid_19_data"
GROUP BY month_start
ORDER BY avg_monthly_cases
DESC LIMIT 10;





