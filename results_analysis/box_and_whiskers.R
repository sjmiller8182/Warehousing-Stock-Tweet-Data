library(pacman)
p_load(tidyverse, reshape2, dplyr, ggthemes, ggpubr, lmerTest)

serversThree <- read.csv("./results_3_servers.csv", header=T, sep=",", strip.white=T, stringsAsFactors = F,
                         na.strings=c("")) %>% data.frame()
serversFive <- read.csv("./results_5_servers.csv", header=T, sep=",", strip.white=T, stringsAsFactors = F,
                        na.strings=c("")) %>% data.frame()

serversThree <- subset(serversThree, select = -block_size)
serversFive <- subset(serversFive, select = -block_size)

serversThree$server_count <- 3 %>% as.factor() 
serversThree <- serversThree[order(-serversThree$schema),]

serversFive$server_count <- 5 %>% as.factor()
serversFive <- serversFive[order(-serversFive$schema),]

serversAll <- rbind(serversThree, serversFive)
serversAll$schema <- as.factor(serversAll$schema)

plotFrame <- serversAll
plotFrame$server_count <- ifelse(plotFrame$server_count==3, "Three Servers", "Five Servers")
plotFrame$schema <- ifelse(plotFrame$schema==1, "Normalized", "Denormalized")

# Box Plots
ggplot(plotFrame, aes(x=factor(schema),y=time,fill=factor(schema)))+
geom_boxplot() + 
  labs(x = "Schema Type", y = "Query Time", title = "Schema Performance over Cluster Size",
                      subtitle = "75,000 rows") + 
  facet_wrap(~server_count) + 
  theme_fivethirtyeight() +
  theme(axis.text.x=element_text(angle=20,hjust=1,vjust=1, face="bold", size=9), 
        axis.text =element_text(face="bold"),
        axis.title= element_text(face="bold"),
        legend.position="none") +
        #legend.title=element_text("Schema Type"),
       # legend.position=c(0.8,1),
        #legend.justification = c(1, 1)) +
  scale_fill_fivethirtyeight() 

# Line Profile Plots
ggline(plotFrame, x = "server_count", y = "time", color = "schema",
       add = c("mean_se", "dotplot"),
       palette = c("red", "blue")) + 
  labs(x = "Schema Type", y = "Query Time", title = "Schema Performance over Cluster Size",
       subtitle = "75,000 rows") +
  theme_fivethirtyeight() +
  theme(axis.text.x=element_text(angle=20,hjust=1,vjust=1, face="bold", size=9), 
        axis.text =element_text(face="bold"),
        axis.title= element_text(face="bold"),
        legend.position="none") +
  #legend.title=element_text("Schema Type"),
  # legend.position=c(0.8,1),
  #legend.justification = c(1, 1)) +
  scale_fill_fivethirtyeight() 

##########################################
            ## two-way ANOVA ##
##########################################

res.aov2 <- aov(time ~ schema + server_count + schema*server_count, data=serversAll)
anova(res.aov2)
residuals <- resid(res.aov2)
pred <- predict(res.aov2, serversAll)
hist(residuals)
plot(pred, residuals)
