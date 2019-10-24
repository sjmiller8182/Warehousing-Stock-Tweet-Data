--set mapred.tasktracker.reduce|map.tasks.maximum; -- an effort to make the processing faster; it needs improving
set mapreduce.map.memory.mb=8096;
set mapreduce.reduce.memory.mb=10020;
set mapreduce.job.reduces=30;

create database ds7330_term_project_schema; -- this is the normalized schema; only the tables in the E-R diagram go here
create database ds7330_term_raw_data; --this is the database for the data tables we need to create the project database
-- we need a process to get the data into HDFS, then get the tables from R and Python and get them into HDFS
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
------------------------ loading dates table
insert into ds7330_term_project.dates
	select t.times as report_date
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

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
------------------------ loading times table
-- use unique dates from all tables
insert into ds7330_term_project.times
	select t.times as report_time
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

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
insert into ds7330_term_project.companies(
	select symbol as symbol
	    , company as company_name
	    , "NYSE" as market_exchange
	from ds7330_term_raw_data.nyse_symbols nyse
	group by symbol
	        , company
	        , "NYSE"

UNION ALL

	select symbol as symbol
	    , company as company_name
	    , "NASDAQ" as market_exchange
	from ds7330_term_raw_data.nasdaq_symbols nasdaq
	group by symbol
	        , company
	        , "NASDAQ"
);

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
insert into ds7330_term_project.daily(
  select ID as unique_daily_id --primary key
  , trim(left(times, 10)) as report_date -- foreign key
  , symbol -- foreign key
  , open_price
  , close_price
  , high_price
  , low_price
  , trade_volume
  , market
  from ds7330_term_raw_data.daily_prices_20_years
);

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
insert into ds7330_term_project.intraday(
	Select some_random_thing as unique_intra_id -- primary key
	, intra.times as report_dtm
	, trim(left(intra.times, 10)) as report_date
	--, right(regexp_replace(intra.times, '/-', ''), 8) as report_date -- foreign key (need to test this)
	, trim(right(intra.times, 5)) as report_time -- foreign key
	, intra.symbol as symbol -- foreign key
	, market as market
	, volume as trade_volume
	, open as open_price
	, close as close_price
	, high as high_price
	, low as low_price
	, obb.lower_bband_open as open_bollinger_band_low
	, obb.middle_bband_open as open_bollinger_band_close
	, obb.upper_bband_open as open_bollinger_band_high
	, cbb.lower_bband_close as close_bollinger_band_open
	, cbb.middle_bband_close as close_bollinger_band_close
	, cbb.upper_bband_close as close_bollinger_band_high
	, hbb.lower_bband_open as high_bollinger_band_low
	, hbb.middle_bband_open as high_bollinger_band_close
	, hbb.upper_bband_open as high_bollinger_band_high
	, lbb.lower_bband_close as low_bollinger_band_open
	, lbb.middle_bband_close as low_bollinger_band_close
	, lbb.upper_bband_close as low_bollinger_band_high
	, mcdo.macd_open as macd_open
	, mcdo.macd_hist_open as macd_hist_open
	, mcdo.mkacd_signal_open as mkacd_signal_open
	, mcdc.macd_close as macd_close
	, mcdc.macd_hist_close as macd_hist_close
	, mcdc.mkacd_signal_close as mkacd_signal_close
	, mcdh.macd_high as macd_high
	, mcdh.macd_hist_high as macd_hist_high
	, mcdh.mkacd_signal_high as mkacd_signal_high
	, mcdl.macd_low as macd_low
	, mcdl.macd_hist_low as macd_hist_low
	, mcdl.mkacd_signal_low as mkacd_signal_low
	, stoch.slowd as slowd_stochastic
	, stoch.slowk as slowk_stochastic
	from ds7330_term_raw_data.intraday_prices_15_min intra
	right join ( -- keep all dates, even the ones from open table that don't correspond to dates intraday has; we
		  select -- we can get those later
		  	times
		  	, real_lower_band as lower_bband_open
		  	, real_middle_band as middle_bband_open
		  	, real_upper_band as upper_bband_open
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.bbands_open_15_min
		  group by times
		  	, real_lower_band
		  	, real_middle_band
		  	, real_upper_band
		  	, symbol
		  	, market
		  ) obb
	on intra.times = obb.times
	and intra.symbol = obb.symbol
	right join (
		  select 
		  	times
		  	, real_lower_band as lower_bband_close
		  	, real_middle_band as middle_bband_close
		  	, real_upper_band as upper_bband_close
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.bbands_close_15_min
		  ) cbb
	on intra.times = cbb.times
	and intra.symbol = cbb.symbol
	right join (
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
	on intra.times = hbb.times
	and intra.symbol = hbb.symbol
	right join (
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
	on intra.times = lbb.times
	and intra.symbol = lbb.symbol
	right join (
		  select
		  	times
		  	, macd as macd_open
		  	, macd_hist as macd_hist_open
		  	, mkacd_signal as mkacd_signal_open
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_open_15_min
		  group by times
		  	, macd
		  	, macd_hist
		  	, mkacd_signal
		  	, symbol
		  	, market
		  ) mcdo
	on intra.times = mcdo.times
	and intra.symbol = mcdo.symbol
	right join (
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
		  ) mcdo
	on intra.times = mcdc.times
	and intra.symbol = mcdc.symbol
	right join (
		  select
		  	times
		  	, macd as lower_high
		  	, macd_hist as macd_hist_high
		  	, mkacd_signal as mkacd_signal_high
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_high_15_min
		  group by times
		  	, macd_high
		  	, macd_hist_high
		  	, mkacd_signal_high
		  	, symbol
		  	, market
		  ) mcdh
	on intra.times = mcdh.times
	and intra.symbol = mcdh.symbol
	right join (
		  select
		  	times
		  	, macd as macd_low
		  	, macd_hist as macd_hist_low
		  	, mkacd_signal as mkacd_signal_low
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_close_15_min
		  group by
		    times
		  	, macd
		  	, macd_hist
		  	, mkacd_signal
		  	, symbol
		  	, market
		  ) mcdl
	on intra.times = mcdl.times
	and intra.symbol = mcdl.symbol
	right join (
		  select
		  	times
		  	, slowd
		  	, slowk
		  	, symbol
		  	, market
		  	, symbol
		  	, market
		  from ds7330_term_raw_data.macd_close_15_min
		  group by
		    times
		  	, slowd
		  	, slowk
		  	, symbol
		  	, market
		  ) stoch
	on intra.times = stoch.times
	and intra.symbol = stoch.symbol
group by some_random_thing -- primary key
	, intra.times
	, trim(left(intra.times, 10))
	--, right(regexp_replace(intra.times, '/-', ''), 8) -- foreign key (need to test this)
	, trim(right(intra.times, 5)) -- foreign key
	, intra.symbol -- foreign key
	, market
	, volume
	, open
	, close
	, high
	, low
	, obb.lower_bband_open
	, obb.middle_bband_open
	, obb.upper_bband_open
	, cbb.lower_bband_close
	, cbb.middle_bband_close
	, cbb.upper_bband_close
	, hbb.lower_bband_open
	, hbb.middle_bband_open
	, hbb.upper_bband_open
	, lbb.lower_bband_close
	, lbb.middle_bband_close
	, lbb.upper_bband_close
	, mcdo.macd_open
	, mcdo.macd_hist_open
	, mcdo.mkacd_signal_open
	, mcdc.macd_close
	, mcdc.macd_hist_close
	, mcdc.mkacd_signal_close
	, mcdh.macd_high
	, mcdh.macd_hist_high
	, mcdh.mkacd_signal_high
	, mcdl.macd_low
	, mcdl.macd_hist_low
	, mcdl.mkacd_signal_low
	, stoch.slowd
	, stoch.slowk
);

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------