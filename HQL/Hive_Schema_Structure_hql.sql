--set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving
set mapreduce.map.memory.mb=8096;
set mapreduce.reduce.memory.mb=10020;
set mapreduce.job.reduces=30;

create database ds7330_term_project_schema; -- this is the normalized schema; only the tables in the E-R diagram go here
create database ds7330_term_raw_data; --this is the database for the data tables we need to create the project database

create table if not exists ds7330_term_project.dates(
	report_date string -- primary key; dates are unique
);

create table if not exists ds7330_term_project.times(
	report_time string -- primary key; only unique times are allowed
);

--tweets table not in normal form:
create table if not exists ds7330_term_project.twitter_tweet(
	tweet_id string --primary key
	, tweet_text string
	, tweet_date string --foreign key
	, tweet_time string --foreign key
	, user_id string --foreign key
	, symbol string  --foreign key
);

create table if not exists ds7330_term_project.twitter_user(
	user_id string --primary key
	, screen_name string
);

create table if not exists ds7330_term_project.twitter_mention(
	tweet_id string --foreign key
	, user_id string --primary key
	, seq_id --primary key
);

create table if not exists ds7330_term_project.twitter_hashtag( -- only one hashtag per hashtag_id
	hashtag_id string --primary key
	, hashtag string
);

create table if not exists ds7330_term_project.twitter_tweet_hashtag( -- multiple hashtags per tweet_id via hashtag_id
	tweet_id string -- foreign key
	, hashtag_id string --foreign key
	, seq_id bigint --primary key
);

create table if not exists ds7330_term_project.twitter_url( -- only one url per url_id
	url_id string --primary key
	, url string
);

create table if not exists ds7330_term_project.twitter_tweet_url( -- multiple urls per tweet_id via url_id
	tweet_id string --primary key
	, url_id string --foreign key
	, seq_id bigint --foreign key
);

create table if not exists ds7330_term_project.companies(
	symbol string --primary key
	, company_name string
	, market_exchange string
	-- , company_details string
);

create table if not exists ds7330_term_project.daily(
  unique_daily_id bigint
  , report_date string
  , symbol string
  , trade_volume
  , market
  , open_price double
  , close_price double
  , high_price double
  , low_price double
);

create table if not exists ds7330_term_project.intraday(
	unique_intra_id bigint not null --primary key
	, report_date string not null --foreign key
	, report_time string not null
	, symbol string not null --foreign key
	, market string not null
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
	, primary key (unique_intra_id)
	, constraint fk foreign key (report_date) references ds7330_term_project.daily(report_date)
);