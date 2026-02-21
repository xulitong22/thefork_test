## TheFork Analytics Engineer Take-Home Project
### Overview

This project demonstrates an end-to-end analytics workflow using PostgreSQL, dbt, and Looker Studio. The goal is to calculate two key KPIs for TheFork customer base and create interactive visualizations for business insights.

### Tools & Technologies

- PostgreSQL: For storing raw CSV data and building a relational database.

- dbt (Data Build Tool): For data modeling, transformation, and testing.

- Looker Studio: For creating dashboards and visualizing KPIs.

### Project Workflow
1. Data Ingestion

    - Created a raw schema in PostgreSQL to serve as a landing zone for CSV files.

    - Loaded the provided CSV files (offline_customers, online_customers, reservations) into PostgreSQL.

2. dbt Modeling

    - Connected dbt to PostgreSQL to build the project.

    - Followed a medallion architecture:

    #### Bronze Layer

    - Kept raw data barely untouched.

    - Used views as materialization.

    #### Silver Layer

    - Built a star schema for analytics:

        - Dimension tables: dim_customers, dim_restaurants, dim_dates

        - Fact table: fct_reservations

    - Applied transformations:

        - Removed unnecessary metadata columns

        - Combined online and offline customer data

        - Extracted restaurant information from raw data

        - Added dbt tests in schema.yml to ensure data quality

        - Used views for materialization

    #### Gold Layer

    - Created models to calculate two KPIs:

        - Active Last 6 Months

        - 30-Day Repeaters

    - Explored different dimensions for additional insights

    - Exported KPI tables for visualization

3. Dashboard

    - Imported gold-layer KPI tables into Looker Studio

    - Built interactive dashboards to visualize trends and segment KPIs by dimensions such as month, country, and lunch type.

    - Added controls such as date range filters for flexible exploration.

### Looker Studio Report Link
https://lookerstudio.google.com/reporting/2d184c5c-926c-4e34-9cba-fe28a7d16ae7
