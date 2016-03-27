install.packages("twitteR")
install.packages("RCurl")
install.packages("wordcloud")
install.packages("tm")
install.packages("base64enc")

library(twitteR)
library(RCurl)
library(wordcloud)
library(tm)
library(base64enc)

consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''
setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)


Lula <- searchTwitter("Lula", n=100, lang="pt")
Lula_text <- sapply(Lula, function(x) x$getText())
Lula_corpus <- Corpus(VectorSource(Lula_text))

Lula_clean <- tm_map(Lula_corpus, removePunctuation)

Lula_clean <- tm_map(Lula_corpus, content_transformer(tolower))
Lula_clean <- tm_map(Lula_corpus, removeWords,stopwords("portuguese"))
Lula_clean <- tm_map(Lula_corpus, removeNumbers)
Lula_clean <- tm_map(Lula_corpus, stripWhitespace)
Lula_clean <- tm_map(Lula_corpus, removeWords,c("Lula","não","que","como","nem","#","ele","uma","para","vai","com","tem","todo","quer","dilma,","querem","en,","são","por","pela","foi","dos","mas","sobre","fala","pode","dado","via","mais","tiver","quem","ter")

wordcloud(Lula_clean)
