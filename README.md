[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/sjmiller8182/DBMS_Proj/blob/master/LICENSE)
![Travis_CI](https://travis-ci.org/sjmiller8182/DBMS_Proj.svg?branch=master)
![GitHub contributors](https://img.shields.io/github/contributors/sjmiller8182/DBMS_Proj)
![GitHub repo size](https://img.shields.io/github/repo-size/sjmiller8182/DBMS_Proj)


# Big Data Solution for Stock Prices and Tweet Collections

Created by [Stuart Miller](https://github.com/sjmiller8182), [Paul Adams](https://github.com/PaulAdams4361), and [Rikel Djoko](https://github.com/leriky).

This project is currently in progress.
The [project outline](https://github.com/sjmiller8182/DBMS_Proj/blob/master/Project_Outline.md) provides a list of [projected milestones](https://github.com/sjmiller8182/DBMS_Proj/blob/master/Project_Outline.md#milestones-and-status) for completion of the project.

## Problem Statement

We want to build a large-scale data framework that will enable us to store and analyze financial market data and drive future predictions for inverstment.

For this project, we will use the following types of data

* Daily stock prices for all companies traded on the NYSE and the NASDAQ.
* Intra-day values for all companies traded on the NYSE and the NASDAQ.
  * Prices: high, low, open, close,
  * Supporting Values: Brollinger Bands, stochastic oscillators, and moving average CD
  * Intra-day values are at 15 minute intervals
* Tweets from over [100 investment related twitter accounts](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter_handles.txt)

## Overview of the Big Data Solution

![Overview of Solution](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Overview_of_Solution.png)

## Data Warehouse Overview

Two star schemas were designed for this data warehouse: a fully normalized schema and a denormalized schema.
We will investigate the performance of the two schemes in the context of this problem.
Conceptual diagrams of the data warehouse schemas are shown below.

More detailed schema diagrams were created with MySQL WorkBench the schema design can be accessed [here](https://github.com/sjmiller8182/DBMS_Proj/tree/master/reports/support/schemas).

### Snowflake Schema

A diagram of the dataware house snowflake schema is shown below. 

![Snowflake](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Snowflake_Conceptual_Schema.png)

### Denormalized Star Schema

A diagram of the dataware house star schema is shown below. 

![Optimized_Star_Schema](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Star_Conceptual_Schema.png)

## Big Data Solution Implementation

The big data solution is build on AWS.

![Big_data_solution_AWS](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Big_Data_Solution_AWS.png)

## Results

Queries were run on the two schemas with different HDFS block sizes to see the impact of normalization on query time.
The collected data is located [here](https://github.com/sjmiller8182/DBMS_Proj/blob/master/results_analysis/results.csv).
A table summarizing the results is shown below.

|     Schema    | Block Size | Average | Median | Variance |
|:-------------:|:---------:|:--------:|:------:|:--------:|
| Normalized    |   64 MB   |          |        |          |
| Normalized    |   128 MB  |          |        |          |
| Normalized    |   256 MB  |          |        |          |
| Denormalized  |   64 MB   |          |        |          |
| Denormalized  |   128 MB  |          |        |          |
| Denormalized  |   256 MB  |          |        |          |

## Analysis

## Conclusion

## Reports

These reports were created during the course of this project.

* [Project Proposal](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/Proposal.pdf): Initial proposal regarding the problem and the proposed solution for investigation.
* [Initial Project Presentation](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/Initial_Presentation.pdf): A high level overview of the project idea and current status.
* [Project Paper](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/Project_Paper.pdf): **Draft in Work** - A paper describing the project.

## Repo Structure
    .
    ├── HQL              # HQL files for creating the data warehouses
    ├── cli              # The cli for this project
    ├── nifi             # NiFi control scripts
    ├── reports          # Reports generated for the project
    ├── sample_data      # Samples of data used in the project
    ├── scrape_utils     # All code for scraping data
    ├── LICENSE          # All code and analysis is licensed under the MIT license.
    ├── Project_Outline  # General outline of the project and milestone status
    └── README.md
