library(wordcloud2)
library(KoNLP)
data <- readLines("output/yes24.txt", encoding='UTF-8'); data

txt <- extractNoun(data); txt
#undata <- gsub("[[:punct:]]","",txt)
undata <- unlist(txt)
undata2 <- gsub("^[가-힣]","", txt)
text <- Filter(function(x){nchar(x) >= 2}, undata2)
#text <- Filter(function(x){nchar(x) >= 2|nchar(x) <= 4}, undata)
ytext <- nchar(text)
ysort <- head(sort(ytext, decreasing=T))
data <- data.frame(ytext, ysort)

result <- wordcloud2(data = demoFreq)
htmltools::save_html(result,"output/yes24.html")


# 정답
data <- readLines("output/yes24.txt", encoding='UTF-8')
data2 <- unlist(extractNoun(data))
data3 <- gsub("^[가-힣]","", data2)
data4 <- Filter(function(x){nchar(x) >= 2 & nchar(x) <= 4}, data3)
data5 <- table(data4)
data6 <- sort(data5, decreasing = T)
yes24 <- data.frame(data6)

result <- wordcloud2(data = yes24, fontFamily = '휴먼옛체')
