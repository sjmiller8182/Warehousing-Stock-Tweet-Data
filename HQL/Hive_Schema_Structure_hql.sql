--set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving
set mapred.job.queue.name=root.batch;
set mapreduce.map.memory.mb=8096;
set mapreduce.reduce.memory.mb=10020;
set mapreduce.job.reduces=30;

create database ds7330_term_project; -- this is the normalized schema; only the tables in the E-R diagram go here
create database ds7330_term_raw_data; --this is the database for the data tables we need to create the project database

create table if not exists ds7330_term_project.dates(
	report_date string -- primary key; dates are unique
);

create table if not exists ds7330_term_project.times(
	report_time string -- primary key; only unique times are allowed
);

--tweets table not in normal form:
create table if not exists ds7330_term_project.twitter_tweet(
	tweet_id string --primary key; this comes from the file
	, tweet_text string
	, tweet_date string --foreign key
	, tweet_time string --foreign key
	, user_id string --foreign key
	, symbol string  --foreign key
	, mention_id string
	, screen_name string
);

create table if not exists ds7330_term_project.twitter_user(
	user_id string --primary key
	, screen_name string
);

create table if not exists ds7330_term_project.twitter_mention(
	tweet_id string --foreign key
	, user_id string --primary key
	--, seq_id bigint--primary key
);

create table if not exists ds7330_term_project.twitter_hashtag( -- only one hashtag per hashtag_id
	hashtag_id string --primary key
	, hashtag string
);

create table if not exists ds7330_term_project.twitter_tweet_hashtag( -- multiple hashtags per tweet_id via hashtag_id
	tweet_id string -- foreign key
	, hashtag_id string --foreign key
	--, seq_id bigint --primary key
);

create table if not exists ds7330_term_project.twitter_url( -- only one url per url_id
	url_id string --primary key
	, url string
);

create table if not exists ds7330_term_project.twitter_tweet_url( -- multiple urls per tweet_id via url_id
	tweet_id string --primary key
	, url_id string --foreign key
	--, seq_id bigint --foreign key; composite key of tweet_id and substring(url_id, 0, nchar(url_id)-round(nchar(url_id)*.60)
);

create table if not exists ds7330_term_project.companies(
	symbol string --primary key
	, company_name string
	, market_exchange string
	-- , company_details string
);

create table if not exists ds7330_term_project.daily(
   report_date string
  , symbol string
  , trade_volume bigint
  , market string
  , open_price double
  , close_price double
  , high_price double
  , low_price double
);

create table if not exists ds7330_term_project.intraday(
	report_dtm
	, report_date string --foreign key
	, report_time string
	, symbol string --foreign key
	, market string
	, trade_volume string
	, open_price double
	, close_price double
	, high_price double
	, low_price double
	, open_bollinger_band_low double
	, open_bollinger_band_close double
	, open_bollinger_band_high double
	, close_bollinger_band_open double
	, close_bollinger_band_close double
	, close_bollinger_band_high double
	, high_bollinger_band_low double
	, high_bollinger_band_close double
	, high_bollinger_band_high double
	, low_bollinger_band_open double
	, low_bollinger_band_close double
	, low_bollinger_band_high double
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
	, slowd_stochastic double
	, slowk_stochastic double
	, exponential_ma_open double
	, exponential_ma_high double
	, exponential_ma_low double
  	, exponential_ma_close double
	--, primary key (unique_intra_id)
	--, constraint fk foreign key (report_date) references ds7330_term_project.daily(report_date)
);