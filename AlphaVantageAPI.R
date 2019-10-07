library(pacman)
p_load(xts, alphavantager)

####### You'll need to set up an API key with Alpha Advantage (they're free for this R code)
############## API Keys: https://www.alphavantage.co/support/
##################################################################### check metric on system sleep time
#####################################################################
testit <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1 # The cpu usage should be negligible
}
testit(5)
#####################################################################
#####################################################################

x <- c("CSCO","AAPL","CX", "TEX")

for(i in 1:length(x)){
  av_api_key("API_KEY_GOES_HERE")
  # website allows for many different variations of the function below
  temp <- alphavantager::av_get(symbol = x[i], av_fun = "TIME_SERIES_INTRADAY", interval = "15min", outputsize = "full")
  Sys.sleep(5) #sleep the for loop for 5 seconds
  name <- paste0("NASDAQ_15min_",x[i],".csv")
  write.csv(temp, name, row.names = F)
}

#####################################################################
############################### -Fin ################################
#####################################################################