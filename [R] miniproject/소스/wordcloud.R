############################################
# 워드클라우드
############################################
library(KoNLP)
useSejongDic()
library(wordcloud)
library(wordcloud2)

news_title <- readLines("newstitle.txt")
naver_reple <- readLines("naver_reple.txt")
reples <- append(naver_reple, news_title)

wordlist<- sapply(reples, extractNoun, USE.NAMES = F)
class(wordlist)

undata <- unlist(wordlist)
undata
undata <- gsub("[[:punct:][A-z]]", "", undata)


word_table <- table(undata)
word_table

undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
names(final)
word_table2 <- table(undata2)
word_table2

final <- sort(word_table2, decreasing = T)
final<-final[-1] # 미세 제거
final<-final[-1] # 먼지 제거


wordcloud2(final, fontFamily = "휴먼옛체")
wordcloud2(final, fontFamily = "THE개이득")
wordcloud2(final,rotateRatio = 1)
wordcloud2(final,rotateRatio = 0.5)
wordcloud2(final,rotateRatio = 0)
wordcloud2(final,size=0.5,col="random-dark")
wordcloud2(final,size=0.7,col="random-light",backgroundColor = "black")
result<-wordcloud2(data = final);result # str(demoFreq)
wordcloud2(data = final, shape = 'diamond')
wordcloud2(data = final, shape = 'star')
wordcloud2(data = final, shape = 'cardioid')
wordcloud2(data = final, shape = 'triangle-forward')
wordcloud2(data = final, shape = 'triangle')
library(htmlwidgets)
saveWidget(result,"output/tmpwc1.html",selfcontained = T)

