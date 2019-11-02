# Tweet Collection and Storage Spec

This file describe how the collected tweets will be stored.

## Normalized Tables

The following describes the normalized tables. 
This is required for building the data collection backend.

For normalization, id are required.
When IDs are required to generated on-the-fly (i.e. not provided in the tweet), 
they will be generated with a checksumm calculator so that the ID is predictable.
Lets say MD5. 
This should be ok because MD5 has a very low collision rate.

### Tweets

* tweet_id: twitter generated id
* text: raw tweet text
* date: date from the time stamp (%y-%m-%d)
* time: from of day from the time stamp (%H:%M:%S")
* user_id: Value given by the users table
* symbol: any company symbols contained in the tweet (scan the tweet for symbols)

### Twitter_Users

* user_id: MD5 version of handle (without @); built on-the-fly since since twitter id is not necessay known (if known user twitter id)
* screen_name: the twitter screen name


### Hashtags

* hashtag_id: MD5 version of the tag (without #); build on-the-fly
* hashtag: actual tag without the '#'

### URLs

* url_id: MD5 version of the url; build on-the-fly
* url: actual url

## Data Collection/Storage Strategy

This is based on the structure of the tables above.
Store the values for each row of Twitter_Users, HashTags, and URLs on a duplicated row of the Tweets table in separate tables.
Do this because one tweet maps to many instances in the other tables 'on collection.'

### Collection Example

Lets say there is a tweet that mentions some handles,
contains some hashtags,
and references some URLs (shown below).
The tweet would be put in the mentions, hashtags, and urls, table as below.
The data in `text` is mostly a placeholder.

* handles
  * @name
  * @name1
  * @name2
  * @name3
  * @name4
* hashtags
  * AAPL
  * Great
  * BuyMoreApple
  * Siri
  * WhyTimCookWhy
* URLs
  * www.apple.com
  * www.niceapple.com
  * www.weirdapple.com
  * www.coolapple.com
  * www.wehateappleproducts.com

Note the duplication of the information in columns `tweet_id` through `symbol`.
`tweet_symbol_id` is introduced to handle cases where there are multiple stock symbols in a single tweet.
It is an integer generated from the combination of tweet_id and symbol.

#### Mentions

```
tweet_id,   text,                   date,       time,   user_id,    symbol,     mention_id,     screen_name, tweet_symbol_id
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        1523            @name        46572
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4039            @name1       46572
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4982            @name2       46572
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        3748            @name3       46572
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        7362            @name4       46572
123         some text about #AAPL   10/10/2019  1:3:00  1234        TXNZ        1523            @name        75637
123         some text about #AAPL   10/10/2019  1:3:00  1234        TXNZ        4039            @name1       75637
123         some text about #AAPL   10/10/2019  1:3:00  1234        TXNZ        4982            @name2       75637
123         some text about #AAPL   10/10/2019  1:3:00  1234        TXNZ        3748            @name3       75637
123         some text about #AAPL   10/10/2019  1:3:00  1234        TXNZ        7362            @name4       75637
```

#### Hashtags

```
tweet_id,   text,                   date,       time,   user_id,    symbol,     hashtag_id,     hashtag
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        1523            AAPL    
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4039            Great     
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4982            BuyMoreApple    
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        3748            Siri 
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        7362            WhyTimCookWhy
```

#### URLs

```
tweet_id,   text,                   date,       time,   user_id,    symbol,     URL_id,         URL
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        1523            www.apple.com      
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4039            www.niceapple.com
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        4982            www.weirdapple.com
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        3748            www.coolapple.com
123         some text about #AAPL   10/10/2019  1:3:00  1234        AAPL        7362            www.wehateappleproducts.com
```
