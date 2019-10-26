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

Data will be stored in an amazon S3 bucket for long term storage. S3 buckets can be easily integrated with other AWS tools such as EMR. The datalake will be setup on-demand with Amazon EMR.

## Study 

Two schemas will be designed.

1. The first schema will be a general purpose schema in 3NF
2. The second schema will be optimized for the intended task

We will look at the difference in performance in querying data from the datalake under these designs.
