/* This is just an example of an HQL stored procedure to build and append to our tables based on files we have stored in our server.
We can change this as we see fit, and will probably need to once we get real data */
-- We will need to configure this in Hive. This is a relative black box until we get AWS/EMR up and running. It might exist in Hadoop and Hive both
use our_dw_database;

--we will have our own permissions if we have a security table. Otherwise, we use default (we need to figure out what default is:
set mapred.job.queue.name=root.batch;

--only if we want to overwrite pre-existing tables, probably we don't:
--drop table if exists our_dw_database.staging_${hiveconf:stockSymbol}_${hiveconf:stockExchange}_${hiveconf:year}_${hiveconf:date} purge;

--create a new table:
/* in the braces are things that could change. Using the below example, all files dropped in lake "our_dw_database" would start with "stockData" and
include the underscores, but everything in {} are variables depending on what else is there. Always "hiveconf:" */
CREATE external TABLE our_dw_database.stockData_${hiveconf:market}_${hiveconf:stockSymbol}_UpdateTime_${hiveconf:date}(
tradeTime from_unixtime(unix_timestamp('2016/06/01','yyyy/MM/dd hh:mm'),'yyyy-MM-dd')
symbol string,
volume string,
open string,
high string,
low string,
close string,
open_macd string,
open_macd_hist string,
open_macd_signal string,
high_macd string,
high_macd_hist string,
high_macd_signal string,
bollinger_real_lower string,
bollinger_real_middle string,
bollinger_real_upper string
--open_price string, --string is most stable when transferring numbers through this database; it preserves leading zeroes and can easily convert
--date_of_trade string --this can be cast as a data format using from_unixtime() downstream
)
ROW FORMAT DELMITED FIELDS TERMINATED BY '\u'
COLLECTION ITEMS TERMINATED BY ':' --for XML-style non-atomic data
MAP KEYS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE

CREATE external TABLE our_dw_database.tweetData_${hiveconf:contractType}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date}(
stockTicker string,
CompanyName string,
occurence_count int,
proportion_of_all_non_stopwords bigint,
date_of_tweet string,
et_cetera_column_name string
)
ROW FORMAT DELMITED FIELDS TERMINATED BY '\u'
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE

-- this is an example of a directory on the server where we store our data (master node?)
LOCATION 'this/is/the/directory/we/will/have/on/the/server/${hiveconf:stockSymbol}/${hiveconf:year}/';

-- first we would create staging tables essentially forklifted (Sqoop?/NiFi) into Hive since data already structured
insert into table our_dw_database.staging_${hiveconf:stockSymbol}_${hiveconf:stockExchange}_${hiveconf:year}_${hiveconf:date}
	Select market.company_name, market.open_price, market.close_price, market.date_of_trade, twit.proportion_of_all_non_stopwords
	from our_dw_database.stockData_${hiveconf:stockSymbol}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date} market
	join our_dw_database.tweetData_${hiveconf:stockSymbol}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date} twit
	on market.company_name = twit.CompanyName
	and from_unixtime(market.date_of_trade) = from_unixtime(twit.date_of_tweet)
;

-- then we would use those tables to create a master match file where all relevent fields exist for a stock
-- this is not fully normalized since there are multi-valued dependencies (violates 4NF because macd, bbands, stocahstics are dependent on price)
insert into table our_dw_database.stockData_master_file_${hiveconf:market}_${hiveconf:stockSymbol}_UpdateTime_${hiveconf:date}
	Select
	intraDay.timestamp as tradeTime
	, intraDay.symbol as symbol
	, intraDay.volume as volume
	, intraDay.open as open
	, intraDay.high as high
	, intraDay.low as low
	, intraDay.close as close
	, macdOpen.macd as macd_open
	, macdOpen.macd_hist as macd_hist_open
	, macdOpen.macd_signal as macd_signal_open
	, macdHigh.macd as macd_high
	, macdHigh.macd_hist as macd_hist_high
	, macdHigh.macd_signal as macd_signal_high
	, bollinger.real.lower.band as bollinger_real_lower
	, bollinger.real.middle.band as bollinger_real_middle
	, bollinger.real.upper.band as bollinger_real_upper
	, stochastic.slowd as slow_k_stochastic --100 x (Recent Close - Lowest Low (n))/(Highest High (n) - Lowest
	, stochastic.slowk as slow_d_stochastic --3-period (15 minutes x 3) SMA of Slow %K
	, sum(case when twit.${hiveconf:stockSymbol} is null then 0 else 1 end) as public_mention_count
	--, more stuff from twitter if we can use NLP (tokenizer, stopwords, and metrics development - for example, proportions)
	from our_dw_database.${hiveconf:market}_Intraday_15min_${hiveconf:stockSymbol} intraDay
	join our_dw_database.${hiveconf:market}_MACD_Open_15min_${hiveconf:stockSymbol} macdOpen
	on intraDay.symbols${hiveconf:stockSymbol}.i. = macdOpen.symbols${hiveconf:stockSymbol}.i.
	join our_dw_database.${hiveconf:market}_MACD_Open_15min_${hiveconf:stockSymbol} macdHigh
	on macdOpen.symbols${hiveconf:stockSymbol}.i. = macdHigh.symbols${hiveconf:stockSymbol}.i.
	join our_dw_database.${hiveconf:market}_BBands_${hiveconf:stockSymbol} bollinger
	on intraDay.symbols${hiveconf:stockSymbol}.i. = bollinger.symbols${hiveconf:stockSymbol}.i.
	join our_dw_database.${hiveconf:market}_STOCH_${hiveconf:stockSymbol} stochastic
	on intraDay.symbols${hiveconf:stockSymbol}.i. = stochastic.symbols${hiveconf:stockSymbol}.i.
	join our_dw_database.tweetData_${hiveconf:stockSymbol}_${hiveconf:CompanyName}_${hiveconf:year}_${hiveconf:date} twit
	intraDay.symbols${hiveconf:stockSymbol}.i. = twit.symbols${hiveconf:stockSymbol} --this depends on if we can parse out a symbol with Regex
	group by
	intraDay.timestamp
	, intraDay.symbol
	, intraDay.volume
	, intraDay.open
	, intraDay.high
	, intraDay.low
	, intraDay.close
	, macdOpen.macd
	, macdOpen.macd_hist
	, macdOpen.macd_signal
	, macdHigh.macd
	, macdHigh.macd_hist
	, macdHigh.macd_signal
	, bollinger.real.lower.band
	, bollinger.real.middle.band
	, bollinger.real.upper.band
	, stochastic.slowd
	, stochastic.slowk
	;


____________________________________________________________________________________________________________________



drop table ds7330_term_project.intraday_trading_aapl
drop table ds7330_term_project.nasdaq_intraday_15min_aapl 
drop table ds7330_term_project.nasdaq_macd_open_15min_aapl 
drop table ds7330_term_project.nasdaq_stoch_15min_aapl 

-- create a new table called intraday in the ds7330 term project database
create table if not exists ds7330_term_project.intraday2(
times string
,symbol string
,volume bigint
,open double
,high double
,low double
,close double
,band_high double
,band_mid double
,band_low double);

-- populate values into the table from two a join
insert into ds7330_term_project.intraday2 
select
i.times as trade_time
,i.symbol as symbol
,i.volume as volume
,i.open as open_price
,i.high as high_price
,i.low as low_price
,i.close as close_price
,b.real_upper_band as upper_band
,b.real_middle_band as middle_band
,b.real_lower_band as lower_band
from ds7330_term_project.nasdaq_intraday_15min_aapl i
join ds7330_term_project.nasdaq_bbands_open_15min_aapl b
on b.symbol = i.symbol
and b.times = i.times
;

-- test the results
select*
from intraday
limit 20;