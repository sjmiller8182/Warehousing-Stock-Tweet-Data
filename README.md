[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/sjmiller8182/DBMS_Proj/blob/master/LICENSE)

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

Images of the data warehouses are shown below.
Due to image formatting on this web page, it is recommended to view the full images by clicking on the image or by downloading the image.

### Normalized Schema

An effective schema of the normalized dataware house is shown below. 

![Normalized_Schema](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Warehouse_Schema_Normalized.png)

### Opimized Schema

An effective schema of the optimized dataware house is shown below. 

![Optimized_Schema](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Warehouse_Schema_Optimized.png)

This schema was created with MySQL WorkBench the schema design can be accessed [here](https://github.com/sjmiller8182/DBMS_Proj/tree/master/reports/support/schemas).

## Big Data Solution Implementation

The big data solution is build on AWS.

![Big_data_solution_AWS](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/support/images/Big_Data_Solution_AWS.png)

## Results

## Analysis

## Conclusion

## Reports

These reports were created during the course of this project.

* [Project Proposal](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/Proposal.pdf): Initial proposal regarding the problem and the proposed solution for investigation.
* [Initial Project Presentation](https://github.com/sjmiller8182/DBMS_Proj/blob/master/reports/Initial_Presentation.pdf): A high level overview of the project idea and current status.

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
