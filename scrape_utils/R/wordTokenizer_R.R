library(pacman)
p_load(textreadr, NLP, tidytext, dplyr, tidyr, stringr, wordcloud, knitr, DT, tidyr, ggplot2, ggthemes, kableExtra, hunspell, stringdist, qdap, rJava, slam, RCurl)
Sys.getnv("JAVA_HOME")

if(Sys.gentenv("JAVA_HOME") != "")
  + Sys.setenv(JAVA_HOME = "")

s <- read.csv("SomeTestFile.csv", row.names = F, fill = T)
tidy_dat <- tidyr::gather(s, key, word) %>% selecT(word)
tidy_dat$word %>% length() # there are n tokens in this document

iounique(tidy_dat$word) %>% length() # n of these tokens are unique

#tokenize the words
tokens <- tidy_dat %>%
unnest_tokens(word, word) %>%
dplyr::count(word, sort = T) %>%
ungroup()

# check out the top 10 most tokenized words
head(tokens, 10)

# remove stopwords
data("stop_words")
tokens_clean <- tokens %>%
anti_join(stop_words) # to get rid of stopwords and clean tokens

# removing all numbers from text:
nums <- tokens_clean %>% filter(str_detect(word, "^[0-9]")) %>% select(word) %>% unique()
tokens_clean <- tokens_clean %>% anti_join(nums, by = "word")

# This is a build for listing the extra stopwords
badWords <- c("1", "2", "3", "anyOtherWordsToRemove", "etc.")

# remove unique stopwords that snuck in there
uni_sw <- data.frame(word = badWords)
tokens_clean <- tokens_clean %>%
anti_join(uni_sw, by = "word")

#define colors and plot the 50 most common words - this is really neato!
pal <- brewer.pal(8, "Dark2")

tokens_clean %>%
with(wordcloud(word, n, random.order = F, max.words = 50, colors = pal)) # substitute as needed

# move them into a data table
tokens_clean %>% DT::datatable()

theTokens <- tokens_clean %>% data.frame()
colnames(theTokens)

percentTotal <- round(theTokens$n / nrow(s), digits = 2)
theTokens <- data.frame(theTokens, percentTotal)
colnames(theTokens) <- c("Word", "Occurrences", "percentTotal")

# separate stopwords list for now
theTokens <- theTokens %>%
filter(!Word %in% c("some", "words", "we", "want"))
write.csv("SomeNewTestFileForAnalysis.csv", row.names = F)

checkSpell <- check_spelling(theTokens$Word
	,range = 2
	, assume.first.correct = T
	, method = "jw"
	, dictionary = qdapDictionaries::GradyAugmented)
   #, parallel = T
   #, cores = parallel::detectCores()-1 #all but one core
   , n.suggests = 8
   )

check_spelling
dim(checkSpell)

#Merge the parent-level (all unique words with count and proportions) with misspelled words to show only misspelled values
nuDF <- inner_join(theTokens, checkSpell, by = c("Word" = "not.found"))
nuDF <- data.frame(nuDF$Word, nuDF$suggestion, nuDF$Occurrences, nuDF$percentTotal)
nuDF <- distinct(nuDF, .keep_all = F)
colnames(nuDF) <- c("Word", "Suggestion", "Occurrences", "percentTotal")
dim(nuDF)
###### End of spell checker

gregexpr("aa",)

correct <- hunspell_check(theTokens$Word)
thecnicallyCorrect <- head(hunspell_suggest(words[!correct]))
theTokens2 <- data.frame(theTokens, thecnicallyCorrect)

write.csv(theTokens2, "someOtherTestFile.csv", row.names = F)

hist(theTokens$Occurrences)

something <- theToekns[which(theTokens$percentTotal >= 0.99),]
something %>%
DT::datatable()

top5 <- theTokens[which(theTokens$percentTotal >= 0.05),]

top5 %>%
kable() %>%
kable_styling()

ggplot(top5, aes(Occurrences)) +
geom_histogram()
