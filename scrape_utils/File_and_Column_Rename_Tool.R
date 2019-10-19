setwd("")

  df <- data.frame(list.files())
######################################################################################### to add a new name and symbols column
  for(i in 1:nrow(df))
  {
    
    symbolTicker <- substr(as.character(df$list.files..[i]), 13, nchar(as.character(df$list.files..[i]))-4)
    tempDF <- read.csv(as.character(df[i,1]))
    tempDF <- data.frame(tempDF, symbolTicker)
    colnames(tempDF) <- c("times", "real_lower_band", "real_middle_band", "real_upper_band", "symbol")
    filenameUpdated <- paste0("NYSE_BBands_15min_", symbolTicker,".csv")
    write.csv(tempDF, filenameUpdated, row.names = F)
    
  }
################################################################################################################################## 
  
  
  
setwd("")
df <- data.frame(list.files())

for(i in 1:nrow(df))
{

  symbolTicker <- substr(as.character(df$list.files..[i]), 15, nchar(as.character(df$list.files..[i]))-4)
  tempDF <- read.csv(as.character(df[i,1]))
  #colnames(tempDF) <- c("times", "open", "high", "low", "close", "volume", "symbol")
  colnames(tempDF) <-  c("times", "real_lower_band", "real_middle_band", "real_upper_band", "symbol")
  #colnames(tempDF) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol")
  #colnames(tempDF) <- c("times", "slowd", "slowk", "symbol")
  filenameUpdated <- paste0("NASDAQ_BBands_Open_15min_", symbolTicker,".csv")
  write.csv(tempDF, filenameUpdated, row.names = F)
 
}