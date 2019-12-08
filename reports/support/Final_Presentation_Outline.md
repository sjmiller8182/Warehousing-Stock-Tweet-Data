## Final Presentation Outline

### Time Requirements

* Practice Session Saturday (15-20 minutes if we're able to have a presentation)
* Practice Session, closing Sunday morning 10-12 PST (1 hour, for sure)

## Sections

### Problem - Paul (1 slide)

- need to predict stock market data

### Data - Paul (1 slide)

- how we got it - pytwits, R
- what form - JSON (semi-structured), CSV (structured), there are emojis
- what it is and why can't we store it in a conventional database
- need to scale ad hoc since we may gather different types of data beyond these

### Solution - Paul (2 slides)
	
- Big Data Solution slide - a way to structure together disparate data (structured plus unstructured), Data lake and what it is
- Data warehouse - structures data to be accessed
- Parallelism (task vs. data, MapReduce)

### Implementation - what ecosystem for implementation - Riky (3 slides)

- infrastructure resources
- scalability (horizontal vs. vertical)
- possibly the AWS marketplace (checkmark table comparing Google, MS Azure)

### Data warehouse and schema - Stuart (3 slides)

- data warehouse (what is one, why is one, what it's used for, versus conventional DB, pretty pictures)
- schema (normalized snowflake, denormalized star)

### Code example to import data into HDFS, into hive, create Hive tables, insert data - Paul (1 slide)

- have to load data into HDFS
- then load data into Hive
- then build schemas

### Statistical Analysis for performance and inference - Shared (see below) (4 slides)

- MapReduce (how it impacts performance) - Riky (1 slide)
- sampling - Riky (pulling data, 30 because normal) (1 slide)
- two-way anova - Stuart (1 slide)
- what did we find - Stuart (0.5 slides)
- inference to population, causation - Stuart if you want to (0.5 slides)

### Conclusion - Paul (2 slides, maybe 1)

- MapReduce block sizes apply to file-size level data and not the entire database
- Schemas are important, even in paralleled systems
- Our solution allows us to scale relatively infinitely for our business model
- Low risk solution since hardware owned by Amazon

Hue: small picture. Show where to insert query, where to analyze jobs, where to run
