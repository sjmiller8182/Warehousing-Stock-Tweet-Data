# HQL

These scripts are used to create and populate the data warehouse.

* `Hive_Schema_Structure_hql.sql`: This file contains the table creation queries as outlined in our Entity-Relationship model.
* `Hive_Data_hql.sql`: This file contains the queries used to populate the tables created by Hive_Schema_Structure_hql.sql file. **However, this file is currently under development.**

**NOTE**: The schema creates two databases; one for the raw data in put from which the schema tables are built and another in which the schema tables reside.
