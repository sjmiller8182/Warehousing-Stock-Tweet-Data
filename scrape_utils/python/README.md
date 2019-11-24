# scrape_utils/python

This folder contains the scraping utilites written in python

## Requirements

* For python requirements see [`../requirements.txt`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/requirements.txt)

## Data Sources

### Twitter

The scraping utilities for twitter are found in 
[`twitter.py`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter.py).
This builds on Twython and requires the twitter API keys (provided externally).
Scraped tweets are downloaded and stored as JSON.
Post processing tools provided in
[`twitter_post.py`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter_post.py)
convert the JSON files into a format intended to enable
warehouse building in Hive based on the normalized warehouse tables.
A list of the twitter handles scraped for this analysis are located in 
[`twitter_handles.txt`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/twitter_handles.txt).
The storage stategy is described in 
[`tweet_collection_spec.md`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/tweet_collection_spec.md).

**Example**

```python
import twitter as t

twitter_keys = '~/Dropbox/twitterAcess.csv'
twitter_accounts = '../twitter_handles.txt'
t.run_scraper(twitter_keys, twitter_accounts, day_filter = 0)
```
