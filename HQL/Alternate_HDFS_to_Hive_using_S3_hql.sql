--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--@@@ NOTE: you must replace hue_username with your Hue username for all "LOAD DATA INPATH" directories @@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

-- to drop a database with data: drop database databaseName cascade;
set mapred.job.queue.name=root.batch; -- 1st run this
set mapreduce.map.memory.mb=8096; --then run this 
set mapreduce.reduce.memory.mb=10020; --then run this
set mapreduce.job.reduces=30; 
--set mapreduce.block.size.property = 124;--then this and after, run the DDL

create database if not exists ds7330_term_project; -- this is the normalized schema; only the tables in the E-R diagram go here
create database if not exists ds7330_term_raw_data; --this is the database for the data tables we need to create the project database

create table if not exists ds7330_term_raw_data.bbands_close_15_min(
times string
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/bbands_close_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_close_15_min;

create table if not exists ds7330_term_raw_data.bbands_high_15_min(
times string
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/bbands_high_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_high_15_min;

create table if not exists ds7330_term_raw_data.bbands_low_15_min(
times string
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/bbands_low_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_low_15_min;

create table if not exists ds7330_term_raw_data.bbands_open_15_min(
times string
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/bbands_open_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_open_15_min;
-------------------------------------------------------------------- end of bollinger bands

create table if not exists ds7330_term_raw_data.daily_prices_20_years(
times string
, open_price double
, high_price double
, low_price double
, close_price double
, volume bigint
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/daily_prices_20_years.csv'
INTO TABLE ds7330_term_raw_data.daily_prices_20_years;
-------------------------------------------------------------------- end of daily prices

create table if not exists ds7330_term_raw_data.exp_moving_average_15_min(
times string
, exponential_ma_open double
, exponential_ma_high double
, exponential_ma_low double
, exponential_ma_close double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/exp_moving_average_15_min.csv'
INTO TABLE ds7330_term_raw_data.exp_moving_average_15_min;
-------------------------------------------------------------------- end of exponential moving averages

create table if not exists ds7330_term_raw_data.intraday_prices_15_min(
times string
, open double
, high double
, low double
, close double
, volume bigint
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/intraday_prices_15_min.csv'
INTO TABLE ds7330_term_raw_data.intraday_prices_15_min;
-------------------------------------------------------------------- end of intraday prices

create table if not exists ds7330_term_raw_data.macd_close_15_min(
times string
, macd double
, macd_hist double
, mkacd_signal double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/macd_close_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_close_15_min;

create table if not exists ds7330_term_raw_data.macd_high_15_min(
times string
, macd double
, macd_hist double
, mkacd_signal double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/macd_high_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_high_15_min;

create table if not exists ds7330_term_raw_data.macd_low_15_min(
times string
, macd double
, macd_hist double
, mkacd_signal double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/macd_low_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_low_15_min;

create table if not exists ds7330_term_raw_data.macd_open_15_min(
times string
, macd double
, macd_hist double
, mkacd_signal double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/macd_open_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_open_15_min;
-------------------------------------------------------------------- end of moving average convergence/divergence

create table if not exists ds7330_term_raw_data.stochastic_15_min(
times string
, slowd double
, slowk double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/stochastic_15_min.csv'
INTO TABLE ds7330_term_raw_data.stochastic_15_min;
-------------------------------------------------------------------- end of stochastic oscillator indicators

create table if not exists ds7330_term_raw_data.nyse_symbols(
symbol string
, company string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/NYSE_Symbols.txt'
INTO TABLE ds7330_term_raw_data.nyse_symbols;

create table if not exists ds7330_term_raw_data.nasdaq_symbols(
symbol string
, company string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/NASDAQ_Symbols.txt'
INTO TABLE ds7330_term_raw_data.nasdaq_symbols;
-------------------------------------------------------------------- end of nyse and nasdaq symbols

create table if not exists ds7330_term_raw_data.tweet_hashtags(
tweet_id string
, `text` string
, `time` string
, `date` string
, user_id string
, `user` string
, symbol string
, hashtag_id string
, hashtag string
, tweet_symbol_id string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/hashtags.csv'
INTO TABLE ds7330_term_raw_data.tweet_hashtags;

create table if not exists ds7330_term_raw_data.tweet_mentions(
tweet_id string
, `text` string
, `time` string
, `date` string
, user_id string
, `user` string
, symbol string
, mention_id string
, mention string
, tweet_symbol_id string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/mentions.csv'
INTO TABLE ds7330_term_raw_data.tweet_mentions;

create table if not exists ds7330_term_raw_data.tweet_urls(
tweet_id string
, `text` string
, `time` string
, `date` string
, user_id string
, `user` string
, symbol string
, url_id string
, url string
, tweet_symbol_id string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 's3a://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/urls.csv'
INTO TABLE ds7330_term_raw_data.tweet_urls;