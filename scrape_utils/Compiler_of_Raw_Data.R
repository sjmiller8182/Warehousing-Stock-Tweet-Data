setwd("c:/users/pablo/desktop/Newfolder")

#STEP 1
## first, aggregate the NASDAQ data
#########################################################################################
#########################################################################################
###################################### NASDAQ BELOW #####################################
#########################################################################################
#########################################################################################

df <- data.frame(list.files())
df <- df[which(df$list.files..!= "nasdaq_macd_open_15_min.csv"),] # in case the file is already there, don't use in the loop
df <- factor(df)
df <- data.frame(df)

for(i in 1:nrow(df))
{
  
  tempDF <- read.csv(as.character(df[i,1]))
  # create the file in first pass and every pass thereafter, append to it:
  write.table(data.frame(tempDF, "NASDAQ"), file = "nasdaq_bbands_open_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
  #write.table(tempDF, file = "NASDAQ_STOCH.csv", row.names = F, col.names = F, append = T, sep = ",") # without market symbol
}

t <- read.csv("nasdaq_macd_open_15_min.csv")
colnames(t) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol", "market")
write.csv(t, "nasdaq_macd_open_15_min.csv", row.names = F)

#check for confirmation
t <- read.csv("nasdaq_macd_open_15_min.csv")
head(t)
unique(t$symbol)
unique(t$market)

#STEP 2
## next, aggregate the NYSE data
#########################################################################################
#########################################################################################
#################################### NYSE BELOW #########################################
#########################################################################################
#########################################################################################

df <- data.frame(list.files())
df <- df[which(df$list.files..!= "nyse_exp_moving_average_15_min.csv"),] # in case the file is already there, don't use in the loop
df <- factor(df)
df <- data.frame(df)

for(i in 1:nrow(df))
{
  
  tempDF <- read.csv(as.character(df[i,1]))
  # create the file in first pass and every pass thereafter, append to it:
  #write.table(data.frame(tempDF, "NYSE"), file = "nyse_macd_open_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
  write.table(tempDF, file = "nyse_exp_moving_average_15_min.csv", row.names = F, col.names = F, append = T, sep = ",") # without market symbol
}

t <- read.csv("nyse_exp_moving_average_15_min.csv")
#colnames(t) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol", "market")
colnames(t) <- c("times", "exponential_ma_open", "exponential_ma_high", "exponential_ma_low", "exponential_ma_close", "symbol", "market")

write.csv(t, "nyse_exp_moving_average_15_min.csv", row.names = F)

#check for confirmation
t <- read.csv("nyse_exp_moving_average_15_min.csv")
head(t)
unique(t$symbol)
unique(t$market)

#STEP 3
## finally, aggregate the NASDAQ & NYSE data together
#########################################################################################
#########################################################################################
###################################### AGGREGATE BELOW ##################################
#########################################################################################
#########################################################################################

df <- data.frame(list.files())
df <- df[which(df$list.files..!= "exp_moving_average_15_min.csv"),] # in case the file is already there, don't use in the loop
df <- factor(df)
df <- data.frame(df)

for(i in 1:nrow(df))
{
  
  tempDF <- read.csv(as.character(df[i,1]))
  # create the file in first pass and every pass thereafter, append to it:
  write.table(tempDF, file = "exp_moving_average_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
}

t <- read.csv("exp_moving_average_15_min.csv")
  #t <- data.frame(t$X2019.10.22.15.45.00, t$X26.7975, t$X27.8883, t$X28.9791, t$AAL, t$NASDAQ)
  #colnames(t) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol", "market") # MACD
  #colnames(t) <- c("times", "real_lower_band", "real_middle_band", "real_upper_band", "symbol", "market") #Bollinger Bands
  #colnames(t) <- c("times", "slowd", "slowk", "symbol", "market")
  colnames(t) <- c("times", "exponential_ma_open", "exponential_ma_high", "exponential_ma_low", "exponential_ma_close", "symbol", "market")
  write.csv(t, "exp_moving_average_15_min.csv", row.names = F)

#check for confirmation
t <- read.csv("stochastic_15_min.csv")
nrow(t)
head(t)
unique(t$symbol)
unique(t$market)

setwd("c:/users/pablo/desktop/newfolder")