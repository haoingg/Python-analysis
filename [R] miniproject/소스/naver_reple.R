############################################
# 네이버 실시간 댓글 가져오기(현재 서비스 종료)
############################################
url <- 'https://search.naver.com/search.naver?where=realtime&sm=tab_jum&query=%EB%AF%B8%EC%84%B8%EB%A8%BC%EC%A7%80'
remDr$navigate(url)

livereple <- NULL
index <- 1
for (a in 1:200) {
  for (i in 1:10) {
    pagenum <- paste0("div.nrealtime_area ul > li:nth-child(",index,") div > a.desc_txt")
    Page <- remDr$findElements(using='css selector',pagenum)
    index <- index+1
    
    Content <- sapply(Page,function(x){x$getElementText()})
    
    print(Content)
    livereple <- append(livereple, unlist(Content))
    
  }
  btn<-remDr$findElement(using='css selector',"#realTimeSearchBody > div > div.api_more_wrap > a.api_more_multi")
  btn$clickElement()
  print(a)
  Sys.sleep(1)
}
#write(livereple, "naver_reple.txt")
naver_reple <- readLines("naver_reple.txt")
