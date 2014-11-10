library(tm)
library(wordcloud)
library(memoise)
books <<- list("Tweets for Apple" = "twe", "Chase Freedom Credit Card" = "chase", "Citi Simplicity Credit Card" = "citi", "Guess Watch for Women" = "guesswomen")
getTermMatrix <- memoise(function(book) {
  if (!(book %in% books))
    stop("Unknown book")
  text <- readLines(sprintf("./%s.txt", book),
                    encoding="UTF-8")
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, PlainTextDocument)
  myCorpus = tm_map(myCorpus, tolower)
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "apple", "iphone", "lol", "chase", "credit", "card", "citi", "citibank", "watch"))
  myCorpus = tm_map(myCorpus, PlainTextDocument)
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  sort(rowSums(m), decreasing = TRUE)
})
