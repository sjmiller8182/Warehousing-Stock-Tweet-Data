set mapred.tasktracker.reduce|map.tasks.maximum;

create database ds7330_term_project_schema;
create database ds7330_term_raw_data;

create table if not exists ds7330_term_project.dates(
	report_date string --primary key
);

create table if not exists ds7330_term_project.times(
	report_time string --no key
);

--tweets table not in normal form:
create table if not exists ds7330_term_project.tweets(
	tweet_id string --primary key
	, tweet_text string
	, hashtag string
	, mentions bigint
	, tweet_date string --foreign key
	, tweet_time string --foreign key
	, user_id string --foreign key
	, symbol string  --foreign key
);

create table if not exists ds7330_term_project.twitter_users(
	user_id string --primary key
	, screen_name string
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