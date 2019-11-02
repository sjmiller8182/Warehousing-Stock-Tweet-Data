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
LOAD DATA INPATH '/user/hue_username/bbands_close_15_min.csv'
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
LOAD DATA INPATH '/user/hue_username/bbands_high_15_min.csv'
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
LOAD DATA INPATH '/user/hue_username/bbands_low_15_min.csv'
INTO TABLE ds7330_term_raw_data.bbands_low_15_min;

create table if not exists ds7330_term_raw_data.bbands_open_15_min(
times string
, real_lower_band_high double
, real_middle_band_high double
, real_upper_band_high double
, symbol string
, market string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "," ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH '/user/hue_username/bbands_open_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/daily_prices_20_years.csv' 
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
LOAD DATA INPATH '/user/hue_username/exp_moving_average_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/intraday_prices_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/macd_close_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/macd_high_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/macd_low_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/macd_open_15_min.csv' 
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
LOAD DATA INPATH '/user/hue_username/stochastic_15_min.csv' 
INTO TABLE ds7330_term_raw_data.stochastic_15_min;
-------------------------------------------------------------------- end of stochastic oscillator indicators

create table if not exists ds7330_term_raw_data.nyse_symbols(
symbol string
, company string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH '/user/hue_username/NYSE_Symbols.txt' 
INTO TABLE ds7330_term_raw_data.nyse_symbols;

create table if not exists ds7330_term_raw_data.nasdaq_symbols(
symbol string
, company string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t" ESCAPED BY '\\'
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH '/user/hue_username/NASDAQ_Symbols.txt'
INTO TABLE ds7330_term_raw_data.nasdaq_symbols;
-------------------------------------------------------------------- end of stochastic oscillator indicators