#문제1
v1 <- c('Happy', 'Birthday', 'to', 'You')
length(v1)
sum(nchar(v1))

#문제2
v2 <- paste('Happy', 'Birthday', 'to', 'You')
length(v2)
sum(nchar(v2))

#문제2 정답
v2 <- paste(v1, collapse=' ');v2
length(v2)
nchar(v2)

#문제3
paste(LETTERS, 1:10)
paste0(LETTERS, 1:10)

#문제3 정답
paste(LETTERS[1:10], 1:10)
paste0(LETTERS[1:10], 1:10)

#문제4
#v3 <- strsplit('Good Morning', split=' ');v3
v3 <- list('Good', 'Morning');v3

#문제4 정답
string <- 'Good Morning'
(splited_text <- strsplit(string, split=' ')[[1]])
list(splited_text[1], splited_text[2])

#문제5
text1 <- c("Yesterday is history, tommrrow is a mystery, today is a gift!", 
           "That's why we call it the present – from kung fu Panda")

text <- gsub("[[:punct:]]","",text1)
text

#문제5 정답
a <- c("Yesterday is history, tommrrow is a mystery, today is a gift!", 
           "That's why we call it the present – from kung fu Panda")
a <- gsub("[,–]","",a)
a <- strsplit(a," ");a

#문제5
text1 <- c("Yesterday is history, tommrrow is a mystery, today is a gift!", 
           "That's why we call it the present – from kung fu Panda")

text <- gsub("[[:punct:]]","",text1)
text <- gsub("\\s{2}", " ", text1)
splited_text2 <- unlist(strsplit(text, " "))


#문제6
s1 <- "@^^@Have a nice day!! 좋은 하루!! 오늘도 100점 하루...."
#(1) 한글 삭제
r1 <- gsub("[가-힣]","",s1)
r1
#(2) 특수문자 삭제
r2 <- gsub("[[:punct:]]","",s1)
r2
#(3) 한글+특수문자 삭제
r3 <- gsub("[[:punct:]]|[가-힣]","",s1)
r3 <- gsub("[[:punct:][가-힣]]","",s1)
r3
#(4) 100->백 변환
r4 <- gsub("100","백",s1)
r4

#문제7-X
data <- readLines("output/hotel.txt"); data
data1 <- extractNoun(data); data1 #명사 뽑음

undata <- unlist(data1); undata

#명칭
wname1 <- filter(function(x) {nchar(x) >= 2}, undata) #2개 이상 단어 추출
wname <- table(wname1) 
#wname <- head(sort(wname,decreasing=T),10)
wname

#빈도수
wcount <- unlist(data1)
wcount <- head(sort(wcount, decreasing=T),10)
wcount

#정답
f

df <- data.frame(wname, wcount)
write.csv(df, "output/writehotel_top_word.csv")