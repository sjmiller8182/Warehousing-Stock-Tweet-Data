set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving

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
	, market_exchange string
	, company_name string
	, company_details string
);

create table if not exists ds7330_term_project.daily(
  unique_daily_id bigint
  , report_date string
  , symbol string
  , open_price double
  , close_price double
  , high_price double
  , low_price double
);

create table if not exists ds7330_term_project.intraday(
	unique_intra_id bigint --primary key
	, report_date string --foreign key
	, report_time string
	, symbol string --foreign key
	, market string
	, trade_volume string
	, open_price double
	, close_price double
	, high_price double
	, low_price double
	, stochastic_slowd double
	, stochastic_slowk double
	, bollinger_open_lower double
	, bollinger_open_middle double
	, bollinger_open_upper double
	, macd_open double
	, macd_hist_open double
	, mkacd_signal_open double
	, macd_high double
	, macd_hist_high double
	, mkacd_signal_high double
	, macd_low double
	, macd_hist_low double
	, mkacd_signal_low double
	, macd_close double
	, macd_hist_close double
	, mkacd_signal_close double
);