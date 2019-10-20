set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving

create database ds7330_term_project_schema; -- this is the normalized schema; only the tables in the E-R diagram go here
create database ds7330_term_raw_data; --this is the database for the data tables we need to create the project database

------------------------ loading dates table
insert into ds7330_term_project.dates
	select t.times as record_date
	from -- use unique dates from all tables
	(
		select trim(substr(times, 2,11)) as times --these are the dates
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


------------------------ loading times table
-- use unique dates from all tables
insert into ds7330_term_project.dates
	select t.times as record_date
	from
	(
		select trim(substr(times, 13,8)) as times --these are the times
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