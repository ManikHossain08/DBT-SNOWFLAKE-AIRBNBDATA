Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
# DBT-SNOWFLAKE-AIRBNBDATA
# DBT-SNOWFLAKE-AIRBNBDATA

# DBT command to start a project:

Go to the project directory : then 

Create and activate a virtual environment:

bash

python3 -m venv venv
source venv/bin/activate
Install dbt inside it:

bash

pip install dbt-snowflake
Now try:

bash

dbt --version
dbt debug


# Setting up the dbt User an Roles

Executing command: USE ROLE ACCOUNTADMIN

Executing command: CREATE ROLE IF NOT EXISTS TRANSFORM

Executing command: GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN

Executing command: CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH

Executing command: GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM

Executing command: CREATE USER IF NOT EXISTS dbt PASSWORD='dbtPassword123' LOGIN_NAME='dbt' MUST_CHANGE_PASSWORD=FALSE DEFAULT_WAREHOUSE='COMPUTE_WH' DEFAULT_ROLE=TRANSFORM DEFAULT_NAMESPACE='AIRBNB.RAW' COMMENT='DBT user used for data transformation'

Executing command: ALTER USER dbt SET TYPE = LEGACY_SERVICE

Executing command: GRANT ROLE TRANSFORM to USER dbt

Executing command: CREATE DATABASE IF NOT EXISTS AIRBNB

Executing command: CREATE SCHEMA IF NOT EXISTS AIRBNB.RAW

Executing command: GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM

Executing command: GRANT ALL ON DATABASE AIRBNB to ROLE TRANSFORM

Executing command: GRANT ALL ON ALL SCHEMAS IN DATABASE AIRBNB to ROLE TRANSFORM

Executing command: GRANT ALL ON FUTURE SCHEMAS IN DATABASE AIRBNB to ROLE TRANSFORM

Executing command: GRANT ALL ON ALL TABLES IN SCHEMA AIRBNB.RAW to ROLE TRANSFORM

Executing command: GRANT ALL ON FUTURE TABLES IN SCHEMA AIRBNB.RAW to ROLE TRANSFORM


# Importing Raw Tables

Executing command: USE WAREHOUSE COMPUTE_WH

Executing command: USE DATABASE airbnb

Executing command: USE SCHEMA RAW

Executing command: CREATE OR REPLACE TABLE raw_listings (id integer, listing_url string, name string, room_type string, minimum_nights integer, host_id integer, price string, created_at datetime, updated_at datetime)

Executing command: COPY INTO raw_listings (id, listing_url, name, room_type, minimum_nights, host_id, price, created_at, updated_at) from 's3://dbtlearn/listings.csv' FILE_FORMAT = (type = 'CSV' skip_header = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"')

Executing command: CREATE OR REPLACE TABLE raw_reviews (listing_id integer, date datetime, reviewer_name string, comments string, sentiment string)

Executing command: COPY INTO raw_reviews (listing_id, date, reviewer_name, comments, sentiment) from 's3://dbtlearn/reviews.csv' FILE_FORMAT = (type = 'CSV' skip_header = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"')

Executing command: CREATE OR REPLACE TABLE raw_hosts (id integer, name string, is_superhost string, created_at datetime, updated_at datetime)

Executing command: COPY INTO raw_hosts (id, name, is_superhost, created_at, updated_at) from 's3://dbtlearn/hosts.csv' FILE_FORMAT = (type = 'CSV' skip_header = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"')


# Creating Reporter Role

Executing command: USE ROLE ACCOUNTADMIN

Executing command: CREATE ROLE IF NOT EXISTS REPORTER

Executing command: CREATE USER IF NOT EXISTS PRESET PASSWORD='presetPassword123' LOGIN_NAME='preset' MUST_CHANGE_PASSWORD=FALSE DEFAULT_WAREHOUSE='COMPUTE_WH' DEFAULT_ROLE=REPORTER DEFAULT_NAMESPACE='AIRBNB.DEV' COMMENT='Preset user for creating reports'

Executing command: GRANT ROLE REPORTER TO USER PRESET

Executing command: GRANT ROLE REPORTER TO ROLE ACCOUNTADMIN

Executing command: GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE REPORTER

Executing command: GRANT USAGE ON DATABASE AIRBNB TO ROLE REPORTER

Patching Reporter command: GRANT USAGE ON FUTURE SCHEMAS IN DATABASE AIRBNB TO ROLE REPORTER;