## Data Gathering

The data will be gathered using python. APIs will be used when available. 
As data is gathered, it will be stored locally, as buffer, then batch uploaded to AWS (S3). 

### Scrapers to write

- [ ] requester for Twitter (API)
- [ ] requester for NYT (API)
- [ ] requester for Reddit (API?)
- [ ] request scheduler

## Storage

The data will be stored in a datalake based on Hadoop.

The datalake will be setup with Amazon EMR.

* Hadoop
* Hive

## Study 

Two schemas will be designed.

1. The first schema will ne a general purpose schema
2. The second schema will be optimized for the intended task

We will look at the difference in performance in querying data from the datalake under these designs.
