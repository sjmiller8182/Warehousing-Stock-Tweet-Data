create database if not exists ds7330_term_project_normalized;
create database if not exists ds7330_term_raw_data;

create table if not exists ds7330_term_project_normalized.dates(
	report_date char
);

create table if not exists ds7330_term_project_normalized.times(
	report_time char
);

create table if not exists ds7330_term_project_normalized.twitter_tweet(
	tweet_id char
	, tweet_text char
	, tweet_date char
	, tweet_time char
	, user_id char
	, symbol char
	, tweet_symbol_id char
);

create table if not exists ds7330_term_project_normalized.twitter_user(
	user_id char
	, `user` char
);

create table if not exists ds7330_term_project_normalized.twitter_tweet_mention(
	tweet_id char
	, user_id char
);

create table if not exists ds7330_term_project_normalized.twitter_hashtag(
	hashtag_id char
	, hashtag char
);

create table if not exists ds7330_term_project_normalized.twitter_tweet_hashtag(
	tweet_id char
	, hashtag_id char
);

create table if not exists ds7330_term_project_normalized.twitter_url(
	url_id char
	, url char
);

create table if not exists ds7330_term_project_normalized.twitter_tweet_url(
	tweet_id char
	, url_id char
);

create table if not exists ds7330_term_project_normalized.companies(
	symbol char
	, company_name char
	, market_exchange char
);

create table if not exists ds7330_term_project_normalized.daily(
   report_date char
  , symbol char
  , trade_volume bigint
  , market char
  , open_price double
  , close_price double
  , high_price double
  , low_price double
);

create table if not exists ds7330_term_project_normalized.intraday(
	report_dtm char
	, report_date char
	, report_time char
	, symbol char
	, market char
	, trade_volume char
	, open_price double
	, close_price double
	, high_price double
	, low_price double
);

create table if not exists ds7330_term_project_normalized.bollinger_intraday(
	report_dtm char
	, report_date char
	, report_time char
	, symbol char
	, market char
	, open_bollinger_band_lower double
	, open_bollinger_band_middle double
	, open_bollinger_band_upper double
	, close_bollinger_band_lower double
	, close_bollinger_band_middle double
	, close_bollinger_band_upper double
	, high_bollinger_band_lower double
	, high_bollinger_band_middle double
	, high_bollinger_band_upper double
	, low_bollinger_band_lower double
	, low_bollinger_band_middle double
	, low_bollinger_band_upper double
);

create table if not exists ds7330_term_project_normalized.moving_averages_intraday(
	report_dtm char
	, report_date char
	, report_time char
	, symbol char
	, market char
	, macd_open double
	, macd_hist_open double
	, mkacd_signal_open double
	, macd_close double
	, macd_hist_close double
	, mkacd_signal_close double
	, macd_high double
	, macd_hist_high double
	, mkacd_signal_high double
	, macd_low double
	, macd_hist_low double
	, mkacd_signal_low double
);

create table if not exists ds7330_term_project_normalized.exp_ma_intraday(
	report_dtm char
	, report_date char
	, report_time char
	, symbol char
	, market char
	, exponential_ma_open double
	, exponential_ma_high double
	, exponential_ma_low double
  	, exponential_ma_close double
);

create table if not exists ds7330_term_project_normalized.stochastic_intraday(
	report_dtm char
	, report_date char
	, report_time char
	, symbol char
	, market char
	, slowd_stochastic double
	, slowk_stochastic double
);

create table if not exists ds7330_term_raw_data.bbands_close_15_min(
times char
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol char
, market char
);

LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/bbands_close_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_close_15_min 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
LINES TERMINATED BY "," ESCAPED BY '\\';

INTO TABLE ds7330_term_raw_data.bbands_close_15_min;

create table if not exists ds7330_term_raw_data.bbands_high_15_min(
times char
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/bbands_high_15_min.csv' 
INTO TABLE ds7330_term_raw_data.bbands_high_15_min;

create table if not exists ds7330_term_raw_data.bbands_low_15_min(
times char
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/bbands_low_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_low_15_min;

create table if not exists ds7330_term_raw_data.bbands_open_15_min(
times char
, real_lower_band double
, real_middle_band double
, real_upper_band double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/bbands_open_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_open_15_min;

create table if not exists ds7330_term_raw_data.daily_prices_20_years(
times char
, open_price double
, high_price double
, low_price double
, close_price double
, volume bigint
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/daily_prices_20_years.csv'
INTO TABLE ds7330_term_raw_data.daily_prices_20_years;

create table if not exists ds7330_term_raw_data.exp_moving_average_15_min(
times char
, exponential_ma_open double
, exponential_ma_high double
, exponential_ma_low double
, exponential_ma_close double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/exp_moving_average_15_min.csv'
INTO TABLE ds7330_term_raw_data.exp_moving_average_15_min;

create table if not exists ds7330_term_raw_data.intraday_prices_15_min(
times char
, open double
, high double
, low double
, close double
, volume bigint
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/intraday_prices_15_min.csv'
INTO TABLE ds7330_term_raw_data.intraday_prices_15_min;

create table if not exists ds7330_term_raw_data.macd_close_15_min(
times char
, macd double
, macd_hist double
, mkacd_signal double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/macd_close_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_close_15_min;

create table if not exists ds7330_term_raw_data.macd_high_15_min(
times char
, macd double
, macd_hist double
, mkacd_signal double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/macd_high_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_high_15_min;

create table if not exists ds7330_term_raw_data.macd_low_15_min(
times char
, macd double
, macd_hist double
, mkacd_signal double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/macd_low_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_low_15_min;

create table if not exists ds7330_term_raw_data.macd_open_15_min(
times char
, macd double
, macd_hist double
, mkacd_signal double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/macd_open_15_min.csv'
INTO TABLE ds7330_term_raw_data.macd_open_15_min;

create table if not exists ds7330_term_raw_data.stochastic_15_min(
times char
, slowd double
, slowk double
, symbol char
, market char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/stochastic_15_min.csv'
INTO TABLE ds7330_term_raw_data.stochastic_15_min;

create table if not exists ds7330_term_raw_data.nyse_symbols(
symbol char
, company char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/NYSE_Symbols.txt'
INTO TABLE ds7330_term_raw_data.nyse_symbols;

create table if not exists ds7330_term_raw_data.nasdaq_symbols(
symbol char
, company char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/NASDAQ_Symbols.txt'
INTO TABLE ds7330_term_raw_data.nasdaq_symbols;

create table if not exists ds7330_term_raw_data.tweet_hashtags(
tweet_id char
, `text` char
, `time` char
, `date` char
, user_id char
, `user` char
, symbol char
, hashtag_id char
, hashtag char
, tweet_symbol_id char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/hashtags.csv'
INTO TABLE ds7330_term_raw_data.tweet_hashtags;

create table if not exists ds7330_term_raw_data.tweet_mentions(
tweet_id char
, `text` char
, `time` char
, `date` char
, user_id char
, `user` char
, symbol char
, mention_id char
, mention char
, tweet_symbol_id char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/mentions.csv'
INTO TABLE ds7330_term_raw_data.tweet_mentions;

create table if not exists ds7330_term_raw_data.tweet_urls(
tweet_id char
, `text` char
, `time` char
, `date` char
, user_id char
, `user` char
, symbol char
, url_id char
, url char
, tweet_symbol_id char
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INFILE 'c:/users/pablo/desktop/Hadoop_Staging_Copy/urls.csv'
INTO TABLE ds7330_term_raw_data.tweet_urls;

set hive.exec.dynamic.partition.mode=nonstrict;

insert into ds7330_term_project_normalized.dates(
	select trim(subchar(regexp_replace(times, '"', ''), 1, 10)) as report_date
	from ds7330_term_raw_data.intraday_prices_15_min
	group by trim(subchar(regexp_replace(times, '"', ''), 1, 10))
);

insert into ds7330_term_project_normalized.times(
	select trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times))) as report_time
	from ds7330_term_raw_data.intraday_prices_15_min
	group by trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))
);

insert into ds7330_term_project_normalized.companies(
	select nyse.symbol as symbol
	    , nyse.company as company_name
	    , "NYSE" as market_exchange
	from ds7330_term_raw_data.nyse_symbols nyse
	group by symbol
	        , company
	        , "NYSE"

	UNION ALL

	select nasdaq.symbol as symbol
	    , nasdaq.company as company_name
	    , "NASDAQ" as market_exchange
	from ds7330_term_raw_data.nasdaq_symbols nasdaq
	group by symbol
	        , company
	        , "NASDAQ"
);

insert into ds7330_term_project_normalized.daily(
  Select
  cast(subchar(from_unixtime(unix_timestamp(regexp_replace(times, '"',''), 'dd-MMM-yyyy')),0,10) as char) as report_date
  , regexp_replace(symbol, '"','') as symbol
  , volume as trade_volume
  , regexp_replace(market, '"','') as market
  , open_price
  , close_price
  , high_price
  , low_price
  from ds7330_term_raw_data.daily_prices_20_years
  group by
  subchar(from_unixtime(unix_timestamp(regexp_replace(times, '"',''), 'dd-MMM-yyyy')),0,10)
  , regexp_replace(symbol, '"','')
  , volume
  , regexp_replace(market, '"','')
  , open_price
  , close_price
  , high_price
  , low_price
);

insert into ds7330_term_project_normalized.intraday(
	Select
	 regexp_replace(times, '"', '') as report_dtm
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10)) as report_date
    , trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))  as report_time
	, regexp_replace(symbol, '"', '') as symbol
	, regexp_replace(market, '"', '') as market
	, volume as trade_volume
	, open as open_price
	, close as close_price
	, high as high_price
	, low as low_price
	from ds7330_term_raw_data.intraday_prices_15_min
	group by 
	regexp_replace(times, '"', '')
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10))
	, trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))
	, regexp_replace(symbol, '"', '')
	, regexp_replace(market, '"','')
	, volume
	, open
	, close
	, high
	, low
);

insert into ds7330_term_project_normalized.bollinger_intraday(
    Select
    obb.times as report_dtm
    , trim(subchar(regexp_replace(obb.times, '"', ''), 1, 10)) as report_date
    , trim(subchar(regexp_replace(obb.times, '"', ''), (length(regexp_replace(obb.times, '"', ''))-1)-6, length(obb.times)))  as report_time
	, regexp_replace(obb.symbol, '"', '') as symbol
	, regexp_replace(obb.market, '"', '') as market
    , obb.real_lower_band as open_bollinger_band_lower
	, obb.real_middle_band as open_bollinger_band_middle
	, obb.real_upper_band as open_bollinger_band_upper
	, cbb.lower_bband_close as close_bollinger_band_lower
	, cbb.middle_bband_close as close_bollinger_band_middle
	, cbb.upper_bband_close as close_bollinger_band_upper
	, hbb.lower_bband_high as high_bollinger_band_lower
	, hbb.middle_bband_high as high_bollinger_band_middle
	, hbb.upper_bband_high as high_bollinger_band_upper
	, lbb.lower_bband_low as low_bollinger_band_lower
	, lbb.middle_bband_low as low_bollinger_band_middle
	, lbb.upper_bband_low as low_bollinger_band_upper
	from ds7330_term_raw_data.bbands_open_15_min obb
	join (
		  select 
		  	times
		  	, real_lower_band as lower_bband_close
		  	, real_middle_band as middle_bband_close
		  	, real_upper_band as upper_bband_close
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.bbands_close_15_min
		  group by times
		  	, real_lower_band
		  	, real_middle_band
		  	, real_upper_band
		  	, symbol
		  	, market
		  ) cbb
	on obb.times = cbb.times
	and obb.symbol = cbb.symbol
	join (
		  select 
		  	times
		  	, real_lower_band as lower_bband_high
		  	, real_middle_band as middle_bband_high
		  	, real_upper_band as upper_bband_high
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.bbands_high_15_min
		  group by times
		  	, real_lower_band
		  	, real_middle_band
		  	, real_upper_band
		  	, symbol
		  	, market
		  ) hbb
	on obb.times = hbb.times
	and obb.symbol = hbb.symbol
	join (
		  select 
		  	times
		  	, real_lower_band as lower_bband_low
		  	, real_middle_band as middle_bband_low
		  	, real_upper_band as upper_bband_low
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.bbands_low_15_min
		  group by times
		  	, real_lower_band
		  	, real_middle_band
		  	, real_upper_band
		  	, symbol
		  	, market
		  ) lbb
	on obb.times = lbb.times
	and obb.symbol = lbb.symbol
	group by
    obb.times
    , trim(subchar(regexp_replace(obb.times, '"', ''), 1, 10))
    , trim(subchar(regexp_replace(obb.times, '"', ''), (length(regexp_replace(obb.times, '"', ''))-1)-6, length(obb.times)))
	, regexp_replace(obb.symbol, '"', '')
	, regexp_replace(obb.market, '"', '')
    , obb.real_lower_band
	, obb.real_middle_band
	, obb.real_upper_band
	, cbb.lower_bband_close
	, cbb.middle_bband_close
	, cbb.upper_bband_close
	, hbb.lower_bband_high
	, hbb.middle_bband_high
	, hbb.upper_bband_high
	, lbb.lower_bband_low
	, lbb.middle_bband_low
	, lbb.upper_bband_low
);

insert into ds7330_term_project_normalized.moving_averages_intraday(
	Select  
	 regexp_replace(mcdo.times, '"', '') as report_dtm
	, trim(subchar(regexp_replace(mcdo.times, '"', ''), 1, 10)) as report_date
    , trim(subchar(regexp_replace(mcdo.times, '"', ''), (length(regexp_replace(mcdo.times, '"', ''))-1)-6, length(mcdo.times)))  as report_time
	, regexp_replace(mcdo.symbol, '"', '') as symbol
	, regexp_replace(mcdo.market, '"', '') as market
	, mcdo.macd as macd_open
	, mcdo.macd_hist as macd_hist_open
	, mcdo.mkacd_signal as mkacd_signal_open
	, mcdc.macd_close as macd_close
	, mcdc.macd_hist_close as macd_hist_close
	, mcdc.mkacd_signal_close as mkacd_signal_close
	, mcdh.macd_high as macd_high
	, mcdh.macd_hist_high as macd_hist_high
	, mcdh.mkacd_signal_high as mkacd_signal_high
	, mcdl.macd_low as macd_low
	, mcdl.macd_hist_low as macd_hist_low
	, mcdl.mkacd_signal_low as mkacd_signal_low
	from ds7330_term_raw_data.macd_open_15_min mcdo
	join (
		  select
		  	times
		  	, macd as macd_close
		  	, macd_hist as macd_hist_close
		  	, mkacd_signal as mkacd_signal_close
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_close_15_min
		  group by times
		  	, macd
		  	, macd_hist
		  	, mkacd_signal
		  	, symbol
		  	, market
		  ) mcdc
	on mcdo.times = mcdc.times
	and mcdo.symbol = mcdc.symbol
	join (
		  select
		  	times
		  	, macd as macd_high
		  	, macd_hist as macd_hist_high
		  	, mkacd_signal as mkacd_signal_high
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_high_15_min
		  group by times
		  	, macd
		  	, macd_hist
		  	, mkacd_signal
		  	, symbol
		  	, market
		  ) mcdh
	on mcdo.times = mcdh.times
	and mcdo.symbol = mcdh.symbol
	join (
		  select
		  	times
		  	, macd as macd_low
		  	, macd_hist as macd_hist_low
		  	, mkacd_signal as mkacd_signal_low
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_low_15_min
		  group by
		    times
		  	, macd
		  	, macd_hist
		  	, mkacd_signal
		  	, symbol
		  	, market
		  ) mcdl
	on mcdo.times = mcdl.times
	and mcdo.symbol = mcdl.symbol
	group by 
	regexp_replace(mcdo.times, '"', '')
	, trim(subchar(regexp_replace(mcdo.times, '"', ''), 1, 10))
	, trim(subchar(regexp_replace(mcdo.times, '"', ''), (length(regexp_replace(mcdo.times, '"', ''))-1)-6, length(mcdo.times)))
	, regexp_replace(mcdo.symbol, '"', '')
	, regexp_replace(mcdo.market, '"','')
	, mcdo.macd
	, mcdo.macd_hist
	, mcdo.mkacd_signal
	, mcdc.macd_close
	, mcdc.macd_hist_close
	, mcdc.mkacd_signal_close
	, mcdh.macd_high
	, mcdh.macd_hist_high
	, mcdh.mkacd_signal_high
	, mcdl.macd_low
	, mcdl.macd_hist_low
	, mcdl.mkacd_signal_low
);

insert into ds7330_term_project_normalized.stochastic_intraday(
	Select
	 regexp_replace(times, '"', '') as report_dtm
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10)) as report_date
    , trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))  as report_time
	, regexp_replace(symbol, '"', '') as symbol
	, regexp_replace(market, '"', '') as market
	, slowd as slowd_stochastic
	, slowk as slowk_stochastic
	from ds7330_term_raw_data.stochastic_15_min
	group by
	regexp_replace(times, '"', '')
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10))
	, trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))
	, regexp_replace(symbol, '"', '')
	, regexp_replace(market, '"','')
	, slowd
	, slowk
);

insert into ds7330_term_project_normalized.exp_ma_intraday(
	Select
	 regexp_replace(times, '"', '') as report_dtm
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10)) as report_date
    , trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))  as report_time
	, regexp_replace(symbol, '"', '') as symbol
	, regexp_replace(market, '"', '') as market
	, exponential_ma_open as exponential_ma_open
	, exponential_ma_high as exponential_ma_high
	, exponential_ma_low as exponential_ma_low
	, exponential_ma_close as exponential_ma_close
	from ds7330_term_raw_data.exp_moving_average_15_min
	group by
	regexp_replace(times, '"', '')
	, trim(subchar(regexp_replace(times, '"', ''), 1, 10))
	, trim(subchar(regexp_replace(times, '"', ''), (length(regexp_replace(times, '"', ''))-1)-6, length(times)))
	, regexp_replace(symbol, '"', '')
	, regexp_replace(market, '"','')
	, exponential_ma_open
	, exponential_ma_high
	, exponential_ma_low
	, exponential_ma_close
);

insert into ds7330_term_project_normalized.twitter_tweet(
  Select
    tweet_id
    , text
    , `date` as report_date
    , `time`  as report_time
    , user_id
    , regexp_replace(symbol, '"','') as symbol
    , tweet_symbol_id as tweet_symbol_id
  from ds7330_term_raw_data.tweet_urls
  group by
    tweet_id
    , text
    , `date`
    , `time`
    , user_id
    , regexp_replace(symbol, '"','')
    , tweet_symbol_id
);

insert into ds7330_term_project_normalized.twitter_user(
  Select
    user_id
    , `user`
  from ds7330_term_raw_data.tweet_mentions
  group by
    user_id
    , `user`
);

insert into ds7330_term_project_normalized.twitter_tweet_mention(
  Select
    tweet_id
    , user_id
  from ds7330_term_raw_data.tweet_mentions
  group by
    tweet_id
    , user_id
);

insert into ds7330_term_project_normalized.twitter_tweet_url(
  Select
    tweet_id
    , url_id
  from ds7330_term_raw_data.tweet_urls
  group by
    tweet_id
    , url_id
);

insert into ds7330_term_project_normalized.twitter_tweet_hashtag(
  Select
    tweet_id
    , hashtag_id
  from ds7330_term_raw_data.tweet_hashtags
  group by
    tweet_id
    , hashtag_id
);

insert into ds7330_term_project_normalized.twitter_hashtag(
  Select
    hashtag_id
    , hashtag
  from ds7330_term_raw_data.tweet_hashtags
  group by
    hashtag_id
    , hashtag
);

insert into ds7330_term_project_normalized.twitter_url(
  Select
    url_id
    , url
  from ds7330_term_raw_data.tweet_urls
  group by
    url_id
    , url
);