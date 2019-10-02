/* This is just an example of an HQL stored procedure to build and append to our tables based on files we have stored in our server.
We can change this as we see fit, and will probably need to once we get real data */
-- We will need to configure this in Hive. This is a relative black box until we get AWS/EMR up and running. It might exist in Hadoop and Hive both
use our_database;

--we will have our own permissions if we have a security table. Otherwise, we use default (we need to figure out what default is:
set mapred.job.queue.name=root.users;)

--only if we want to overwrite pre-existing tables, probably we don't:
drop table if exists our_database.staging_${hiveconf:stockID}_${hiveconf:stockExchange}_${hiveconf:year}_${hiveconf:date} purge;

--create a new table:
/* in the braces are things that could change. Using the below example, all files dropped in lake "our_database" would start with "stockData" and
include the underscores, but everything in {} are variables depending on what else is there. Always "hiveconf:" */
CREATE external TABLE our_database.stockData_${hiveconf:stockID}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date}(
stock_ticker string,
company_name string,
open_price string, --string is most stable when transferring numbers through this database; it preserves leading zeroes and can easily convert
close_price string,
date_of_trade string, --this can be cast as a data format using from_unixtime() downstream
proportion_of_all_non_stopwords bigint,
et_cetera_column_name string
)
ROW FORMAT DELMITED FIELDS TERMINATED BY '\u0001'
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE

CREATE external TABLE our_database.tweetData_${hiveconf:contractType}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date}(
stockTicker string,
CompanyName string,
occurence_count int,
proportion_of_all_non_stopwords bigint,
date_of_tweet string,
et_cetera_column_name string
)
ROW FORMAT DELMITED FIELDS TERMINATED BY '\u0001'
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE

-- this will be the directory on the server where we store our data
LOCATION 'this/is/the/directory/we/will/have/on/the/server/${hiveconf:stockID}/${hiveconf:year}/';

insert into table our_database.staging_${hiveconf:stockID}_${hiveconf:stockExchange}_${hiveconf:year}_${hiveconf:date}
	Select market.company_name, market.open_price, market.close_price, market.date_of_trade, twit.proportion_of_all_non_stopwords
	from our_database.stockData_${hiveconf:stockID}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date} market
	join our_database.tweetData_${hiveconf:stockID}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date} twit
	on market.company_name = twit.CompanyName
	and from_unixtime(market.date_of_trade) = from_unixtime(twit.date_of_tweet)
;