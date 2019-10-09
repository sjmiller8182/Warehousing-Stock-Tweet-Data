## Data Gathering

The data will be gathered using python. APIs will be used when available. 
As data is gathered, it will be stored locally, as buffer, then batch uploaded to AWS (S3). 

### Scrapers to write

- [X] Twitter (API)
- [ ] NYT (API)
- [ ] StockNewsAPI (API)
- [ ] Reddit (API)
- [X] AlphaVantageAPI
- [ ] ~~requester for StockTwits~~ Disallowed by TOC

### Source Details

* Twitter - Collect daily tweets from notable finance related accounts such as `@jimcramer`
  * Current [`handles`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter_handles.txt) being scraped
* NYT - Collect headlines related to stock symbols (should be more recent)

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

### Potential Extensions

* Preprocess text
  * Clean the text
  * Vectorize with a pretrained tool
    * [AllanNLP](https://allennlp.org/)
    * [IXA Pipelines](http://ixa2.si.ehu.es/ixa-pipes/)
* Use a continuous data ingestion platform

## Storage

The data will be stored in a datalake based on Hadoop.

The datalake will be setup with Amazon EMR.

* Hadoop
* Hive

## Study 

Two schemas will be designed.

1. The first schema will be a general purpose schema
2. The second schema will be optimized for the intended task

We will look at the difference in performance in querying data from the datalake under these designs.
