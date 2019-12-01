library(tidyverse)
library(lmerTest)

df <- read_csv('./results.csv',
                 col_types = cols(
                   schema = col_factor(levels = c('1','0')),
                   block_size = col_factor(levels = c('64','128','256')),
                   server_num = col_factor(levels = c('3','5')),
                   time = col_double()
                 )
       )

df$server_num <- recode(df$server_num, '3' = 'three_nodes', '5' = 'five_nodes')
df$schema <- recode(df$schema, '1' = 'normalized', '0' = 'denormalized')

# original mixed effects model
fit <- lmer(time ~ schema + block_size + schema*block_size  + (1|block_size), data=df)
anova(fit)
summary(fit)

residuals <- resid(fit)
pred <- predict(fit, df)

hist(residuals)
plot(pred, residuals)

# accounting for server size

fit <- lmer(time ~ schema + block_size + schema*block_size*server_num  + (1|block_size), data=df)
anova(fit)
summary(fit)

residuals <- resid(fit)
pred <- predict(fit, df)

hist(residuals)
plot(pred, residuals)

summary(glht(fit, linfct=mcp(server_num="Tukey")))
