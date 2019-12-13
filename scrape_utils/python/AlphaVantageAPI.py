from alpha_vantage.timeseries import TimeSeries
from alpha_vantage.techindicators import TechIndicators
import time
# import os

# os.chdir("./")

api_key = 'H79JS0TW550361US'

ts = TimeSeries(api_key, output_format='pandas')

symbols = ['AAPL', 'CSCO']

errFile = open("badSymbols.txt", "w+")

for i in range(0, len(symbols)):
    ti = TechIndicators(symbols[i])

    try: 
        stock_daily, stock_meta_data_daily = ts.get_daily(symbol=symbols[i]
                                                             , outputsize='full')

        stock_intraday, stock_meta_data_intraday = ts.get_intraday(symbol=symbols[i],
                                                                      outputsize='full')

        fileOut = (symbols[i] + "_" + "daily.csv")
        fileOut = str(fileOut)
        stock_daily['Symbol'] = symbols[i]
        stock_daily.rename(columns = {'1. open': 'open_price', '2. high': 'high_price',
                                      '3. low': 'low_price', '4. close': 'close_price',
                                      '5. volume': 'trade_volume'}, inplace=True)
        stock_daily.to_csv(fileOut)
        
        fileOut = (symbols[i] + "_" + "intraday.csv")
        fileOut = str(fileOut)
        stock_intraday['Symbol'] = symbols[i]
        stock_intraday.rename(columns = {'1. open': 'open_price', '2. high': 'high_price',
                                      '3. low': 'low_price', '4. close': 'close_price',
                                      '5. volume': 'trade_volume'}, inplace=True)
        stock_intraday.to_csv(fileOut)

        time.sleep(3)
    
    except:
        with open("badSymbols.txt", "a") as myfile:
            myfile.write(symbols[i] + "\n")