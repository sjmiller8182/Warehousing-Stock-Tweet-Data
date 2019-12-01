############################################################# Denormalized below
--set dfs.block.size=268435456; --this is for the 256MB blocks
--set dfs.block.size=134217728; --this is for the 128MB blocks
set dfs.block.size=67108864; --this is for the 64MB blocks

select i.report_dtm, i.report_date, i.report_time, i.symbol, i.market, c.company_name, i.trade_volume, i.open_price, i.close_price, i.high_price, i.low_price, d.open_price, d.close_price, d.high_price, d.low_price
	, ht.tweet_id, ht.text, ht.`date`, ht.`time`, ht.user_id, ht.tweet_symbol_id, ht.hashtag_id, u.url_id, u.url, i.open_bollinger_band_lower, i.open_bollinger_band_middle, i.open_bollinger_band_upper, i.close_bollinger_band_lower
	, i.close_bollinger_band_middle, i.close_bollinger_band_upper, i.high_bollinger_band_lower, i.high_bollinger_band_middle, i.high_bollinger_band_upper, i.low_bollinger_band_lower, i.low_bollinger_band_middle, i.low_bollinger_band_upper
	, i.exponential_ma_low, i.exponential_ma_open, i.exponential_ma_high, i.exponential_ma_close, i.macd_open, i.macd_hist_open, i.mkacd_signal_open, i.macd_close, i.macd_hist_close, i.mkacd_signal_close, i.macd_high, i.macd_hist_high
	, i.mkacd_signal_high, i.macd_low, i.macd_hist_low, i.mkacd_signal_low, i.slowd_stochastic, i.slowk_stochastic
from ds7330_term_project_denormalized.intraday i
left join ds7330_term_project_denormalized.companies c
	on i.symbol = c.symbol
	and i.market = c.market_exchange
left join ds7330_term_project_denormalized.daily d
	on i.report_date = d.report_date
	and i.symbol = d.symbol
	and i.market = d.market
left join ds7330_term_project_denormalized.dates dt
	on i.report_date = dt.report_date
left join ds7330_term_project_denormalized.times tm
	on i.report_time = tm.report_time
left join ds7330_term_project_denormalized.tweet_hashtags ht
	on substring(i.report_date, 3, 8) = to_date(ht.`date`)
	--and i.report_time = to_date(ht.`time`)
	and i.symbol = ht.symbol
left join ds7330_term_project_denormalized.tweet_mentions m
	on substring(i.report_date, 3, 8) = to_date(m.`date`)
	--and i.report_time = to_date(m.`time`)
and i.symbol = m.symbol
left join ds7330_term_project_denormalized.tweet_urls u
	on substring(i.report_date, 3, 8) = to_date(u.`date`)
	--and i.report_time = to_date(u.`time`)
	and i.symbol = u.symbol
group by i.report_dtm, i.report_date, i.report_time, i.symbol, i.market, c.company_name, i.trade_volume, i.open_price, i.close_price, i.high_price, i.low_price, d.open_price, d.close_price, d.high_price, d.low_price
	, ht.tweet_id, ht.text, ht.`date`, ht.`time`, ht.user_id, ht.tweet_symbol_id, ht.hashtag_id, u.url_id, u.url, i.open_bollinger_band_lower, i.open_bollinger_band_middle, i.open_bollinger_band_upper, i.close_bollinger_band_lower
	, i.close_bollinger_band_middle, i.close_bollinger_band_upper, i.high_bollinger_band_lower, i.high_bollinger_band_middle, i.high_bollinger_band_upper, i.low_bollinger_band_lower, i.low_bollinger_band_middle, i.low_bollinger_band_upper
	, i.exponential_ma_low, i.exponential_ma_open, i.exponential_ma_high, i.exponential_ma_close, i.macd_open, i.macd_hist_open, i.mkacd_signal_open, i.macd_close, i.macd_hist_close, i.mkacd_signal_close, i.macd_high, i.macd_hist_high
	, i.mkacd_signal_high, i.macd_low, i.macd_hist_low, i.mkacd_signal_low, i.slowd_stochastic, i.slowk_stochastic
limit 75000
