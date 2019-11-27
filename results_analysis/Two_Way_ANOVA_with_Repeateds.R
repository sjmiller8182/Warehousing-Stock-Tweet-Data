df <- read.csv("./results.csv")

library(lmerTest)
fit <- lmer(time ~ schema + block_size + schema*block_size  + (1|block_size), data=df)
anova(fit)
