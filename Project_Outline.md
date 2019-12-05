
# Milestones and Status

The following table shows milestone identified to complete the project.

| Milestones                                  | Planned Completion | Actual Completion  | Status   |
|---------------------------------------------|:------------------:|:------------------:|:--------:|
| AWS infrastructure Setup                    | Oct. 6, 2019       | Oct. 6, 2019       | Complete |
| Initial Data Collection Complete            | Oct. 6, 2019       | Oct. 6, 2019       | Complete |
| Design Normalized Schema                    | Oct. 27, 2019      | Oct. 27, 2019      | Complete |
| Design Optimized Schema                     | Oct. 27, 2019      | Nov. 3, 2019       | Complete |
| Integrate All Tools (full system)           | Nov. 3, 2019       | Nov. 17, 2019      | Complete |
| Verify Data WareHouse Builds (both schemas) | Nov. 3, 2019       | Nov. 3, 2019       | Complete |
| Rough Draft of Paper                        | Nov. 10, 2019      | Nov. 10, 2019      | Complete |
| Test Performance                            | Nov. 17, 2019      | Nov. 24, 2019      | Complete |
| Complete Final Presentation                 | Dec. 1, 2019       | Dec. 1, 2019       | Complete |
| Complete Final Paper                        | Dec. 8, 2019       | Dec. 8, 2019       | Complete |

# Detailed Steps

The following details are expected for completion of the project.

## Initial Data Gathering

The data will be gathered using python. 
APIs will be used when available. 
As data is gathered, it will be stored locally, as buffer, then batch uploaded to AWS (S3).
Later this will be moved to automatic data ingestion pipeline.

### Scrapers to write

- [X] Twitter (API)
- [X] AlphaVantageAPI
- [ ] ~~requester for StockTwits~~ Disallowed by TOC

### Source Details

* Twitter - Collect daily tweets from notable finance related accounts such as `@jimcramer`
  * Current [`handles`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter_handles.txt) being scraped

### Technical Details

* Twitter
  * Scrape tweets from handles daily
  * Store tweets in JSON, files named: <screen_name>_<time_created>.txt
  * Store 'important' features in tsv file, named: <screen_name>_<date>.txt
    * tweet_id
    * text
    * hashtags
    * mentions
    * urls
    * created_at
    * user_id
    * screen_name
  * Push results to an S3 bucket

## Data Ingestion

NiFi will be used to bring in data from web sources. This data will be pushed to an S3 bucket for long-term storage.

## Storage

Data will be stored in an amazon S3 bucket for long term storage. 
S3 buckets can be easily integrated with other AWS tools such as EMR. 
The datalake will be setup on-demand with Amazon EMR and Hive.

## Study 

Two schemas will be designed. 
One will be a general purpose normalized schema and the second will be a non-normalized optimized schema.
We will look at the difference in performance in querying data from the datalake under these designs.

### Schemas

- [X] General purpose schema in 3NF
- [X] Optimized schema

## Potential Extensions

* Scrape with multiple agents
* Bring in data from other sources
  * NYT (API)
  * StockNewsAPI (API)
  * Reddit (API)
  * Other alternative data such as weather events
* Preprocess text
  * Clean the text
  * Vectorize with a pretrained tool
    * [AllanNLP](https://allennlp.org/)
    * [IXA Pipelines](http://ixa2.si.ehu.es/ixa-pipes/)
* Use a continuous data ingestion platform
