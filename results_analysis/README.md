# results_analysis

## Results

Testing results are contained in [`results.csv`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/results_analysis/results.csv)

Column meanings:

* **schema** - data warehouse schema (1 - snowflake design, 0 - denormalized star schema).
* **block_size** - MapReduce block size (64, 128, 256) in megabytes.
* **time** - time to process query in seconds.

## Analysis

The full analysis was carried out in R in [`analysis`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/results_analysis/analysis.md).
The analysis source code is [here](https://github.com/sjmiller8182/DBMS_Proj/blob/master/results_analysis/analysis.Rmd) 
