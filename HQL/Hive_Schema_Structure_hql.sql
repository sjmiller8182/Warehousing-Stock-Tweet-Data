set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving

create database ds7330_term_project_schema; -- this is the normalized schema; only the tables in the E-R diagram go here
create database ds7330_term_raw_data; --this is the database for the data tables we need to create the project database

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------creating dates table-----------------------------------------------------completed, tested below
----------------------------------------------------------------------
----------------------------------------------------------------------
create table if not exists ds7330_term_project.dates(
	report_date string --primary key
);

-- use unique dates from all tables
insert into ds7330_term_project.dates
	select t.times as record_date
	from
	(
		select trim(substr(times, 2,11)) as times --as date_of_day, trim(substr(times, 13,8)) as time_of_day
		from ds7330_term_raw_data.nasdaq_bbands_open_15min_aapl
		group by trim(substr(times, 2,11))

		UNION ALL

		select trim(substr(times, 2,11)) as times
		from ds7330_term_raw_data.nasdaq_intraday_15min_aapl
		group by trim(substr(times, 2,11))

		UNION ALL

		select trim(substr(times, 2,11)) as times
		from ds7330_term_raw_data.nasdaq_macd_open_15min_aapl
		group by trim(substr(times, 2,11))

		UNION ALL

		select trim(substr(times, 2,11)) as times
		from ds7330_term_raw_data.nasdaq_macd_high_15min_aapl
		group by trim(substr(times, 2,11))

		UNION ALL

		select trim(substr(times, 2,11)) as times
		from ds7330_term_raw_data.nasdaq_macd_low_15min_aapl
		group by trim(substr(times, 2,11))

		UNION ALL

		select trim(substr(times, 2,11)) as times
		from ds7330_term_raw_data.nasdaq_macd_close_15min_aapl
		group by trim(substr(times, 2,11))
	) as t

	group by t.times
;
----------------------------------------------------------------------
----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------completed, tested above
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
------------------------ creating times table -------------------------------------------------------completed, tested below
----------------------------------------------------------------------
----------------------------------------------------------------------
create table if not exists ds7330_term_project.times(
	report_time string --no key
);

-- use unique dates from all tables
insert into ds7330_term_project.dates
	select t.times as record_date
	from
	(
		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_bbands_open_15min_aapl
		group by trim(substr(times, 13,8))

		UNION ALL

		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_intraday_15min_aapl
		group by trim(substr(times, 13,8))

		UNION ALL

		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_macd_open_15min_aapl
		group by trim(substr(times, 13,8))

		UNION ALL

		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_macd_high_15min_aapl
		group by trim(substr(times, 13,8))

		UNION ALL

		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_macd_low_15min_aapl
		group by trim(substr(times, 13,8))

		UNION ALL

		select trim(substr(times, 13,8)) as times
		from ds7330_term_raw_data.nasdaq_macd_close_15min_aapl
		group by trim(substr(times, 13,8))
	) as t

	group by t.times
;
----------------------------------------------------------------------
----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------completed, tested above
----------------------------------------------------------------------
----------------------------------------------------------------------


----------------------------------------------------------------------
----------------------------------------------------------------------
------------------------ creating tweets table ----------------------------------------------- not started
----------------------------------------------------------------------
----------------------------------------------------------------------

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

----------------------------------------------------------------------
----------------------------------------------------------------------
------------------ creating twitter users table ---------------------------------------------- not started
----------------------------------------------------------------------
----------------------------------------------------------------------
create table if not exists ds7330_term_project.twitter_users(
	user_id string --primary key
	, screen_name string
);




----------------------------------------------------------------------
----------------------------------------------------------------------
---------------------- creating companies table -----------------------------------------------------completed, tested below
----------------------------------------------------------------------
----------------------------------------------------------------------

create table if not exists ds7330_term_project.companies(
	symbol string --primary key
	, market_exchange string
	, company_name string
	, company_details string
);

insert into ds7330_term_project.companies
select symbol as symbol
    , company as company_name
    , "NYSE" as market_exchange
from ds7330_term_raw_data.nyse_symbols nyse
group by symbol
        , company
;

insert into ds7330_term_project.companies
select symbol as symbol
    , company as company_name
    , "NASDAQ" as market_exchange
from ds7330_term_raw_data.nasdaq_symbols nasdaq
group by symbol
        , company
;
----------------------------------------------------------------------
----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------completed, tested above
----------------------------------------------------------------------
----------------------------------------------------------------------

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