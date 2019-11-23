############################################################# Normalized below
select count(*)
from ds7330_term_project.intraday i
join ds7330_term_project.twitter_tweet t
on i.symbol = t.symbol
and substring(i.report_date, 3, 8) = t.tweet_date
left join ds7330_term_project.twitter_tweet_hashtag tht
on t.tweet_id = tht.tweet_id
left join ds7330_term_project.twitter_hashtag ht
on tht.hashtag_id = ht.hashtag_id
left join ds7330_term_project.twitter_tweet_mention m
on t.tweet_id = m.tweet_id
left join ds7330_term_project.twitter_tweet_url tu
on t.tweet_id = tu.tweet_id
left join ds7330_term_project.twitter_url u
on u.url_id = tu.url_id
left join ds7330_term_project.twitter_user us
on us.user_id = t.user_id
left join ds7330_term_project.bollinger_intraday bi
on i.report_date = bi.report_date
and i.report_time = bi.report_time
and i.symbol = bi.symbol
left join ds7330_term_project.exp_ma_intraday ei
on i.report_date = ei.report_date
and i.report_time = ei.report_time
and i.symbol = ei.symbol
left join ds7330_term_project.moving_averages_intraday mi  
on i.report_date = mi.report_date
and i.report_time = mi.report_time
and i.symbol = mi.symbol
left join ds7330_term_project.stochastic_intraday si  
on i.report_date = si.report_date
and i.report_time = si.report_time
and i.symbol = si.symbol
left join ds7330_term_project.companies c
on i.symbol = c.symbol
and i.market = c.market_exchange
left join ds7330_term_project.daily d
on i.report_date = d.report_date
and i.symbol = d.symbol
and i.market = d.market
left join ds7330_term_project.dates dt
on i.report_date = dt.report_date
left join ds7330_term_project.times tm
on i.report_time = tm.report_time

############################################################# Optimized below
select count(*)
from ds7330_term_project.intraday i
left join ds7330_term_project.companies c
on i.symbol = c.symbol
and i.market = c.market_exchange
left join ds7330_term_project.daily d
on i.report_date = d.report_date
and i.symbol = d.symbol
and i.market = d.market
left join ds7330_term_project.dates dt
on i.report_date = dt.report_date
left join ds7330_term_project.times tm
on i.report_time = tm.report_time
left join ds7330_term_project.tweet_hashtags ht
on substring(i.report_date, 3, 8) = to_date(ht.`date`)
--and i.report_time = to_date(ht.`time`)
and i.symbol = ht.symbol
left join ds7330_term_project.tweet_mentions m
on substring(i.report_date, 3, 8) = to_date(m.`date`)
--and i.report_time = to_date(m.`time`)
and i.symbol = m.symbol
left join ds7330_term_project.tweet_urls u
on substring(i.report_date, 3, 8) = to_date(u.`date`)
--and i.report_time = to_date(u.`time`)
and i.symbol = u.symbol
