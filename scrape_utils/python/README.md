## scrape_utils/python

This folder contains the scraping utilites written in python

### Requirements

* For python requirements see [`../requirements.txt`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/requirements.txt)
* Chrome web driver is also required

### Data Sources

#### Twitter

The scraping utilities for twitter are found in `twitter.py`.
This builds on Twython and requires the twitter API keys (provided externally).
Collected tweets are stored in a format intended to enable warehouse building in Hive based on the normalized warehouse tables.
The storage stategy is described in [`tweet_collection_spec.md`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/scrape_utils/python/tweet_collection_spec.md).

