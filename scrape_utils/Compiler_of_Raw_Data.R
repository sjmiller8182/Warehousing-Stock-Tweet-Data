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
  write.table(data.frame(tempDF, "NASDAQ"), file = "nasdaq_macd_open_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
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
df <- df[which(df$list.files..!= "nyse_macd_open_15_min.csv"),] # in case the file is already there, don't use in the loop
df <- factor(df)
df <- data.frame(df)

for(i in 1:nrow(df))
{
  
  tempDF <- read.csv(as.character(df[i,1]))
  # create the file in first pass and every pass thereafter, append to it:
  write.table(data.frame(tempDF, "NYSE"), file = "nyse_macd_open_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
  #write.table(tempDF, file = "NYSE_STOCH.csv", row.names = F, col.names = F, append = T, sep = ",") # without market symbol
}

t <- read.csv("nyse_macd_open_15_min.csv")
colnames(t) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol", "market")
write.csv(t, "nyse_macd_open_15_min.csv", row.names = F)

#check for confirmation
t <- read.csv("nyse_macd_open_15_min.csv")
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
df <- df[which(df$list.files..!= "macd_open_15_min.csv"),] # in case the file is already there, don't use in the loop
df <- factor(df)
df <- data.frame(df)

for(i in 1:nrow(df))
{
  
  tempDF <- read.csv(as.character(df[i,1]))
  # create the file in first pass and every pass thereafter, append to it:
  write.table(tempDF, file = "macd_open_15_min.csv", row.names = F, col.names = F, append = T, sep = ",")
}

t <- read.csv("macd_open_15_min.csv")
colnames(t) <- c("times", "macd", "macd_hist", "mkacd_signal", "symbol", "market")
write.csv(t, "macd_open_15_min.csv", row.names = F)

#check for confirmation
t <- read.csv("macd_open_15_min.csv")
nrow(t)
head(t)
unique(t$symbol)
unique(t$market)
