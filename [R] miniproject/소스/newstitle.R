############################################
# 뉴스 기사 제목 가져오기
############################################
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url <- 'https://search.naver.com/search.naver?query=%EB%AF%B8%EC%84%B8%EB%A8%BC%EC%A7%80&where=news&ie=utf8&sm=nws_hty'
remDr$navigate(url)

reple <- NULL

for (i in 1:400){
  # 기사 제목 저장
  content<-remDr$findElements(using ="css selector","ul.list_news li.bx  div  div > a.news_tit")
  reple_v <- sapply(content,function(x){x$getElementText()})  
  Sys.sleep(1)
  print(reple_v)
  reple <- append(reple, unlist(reple_v))
  
  
  # 페이지 이동
  btn<-remDr$findElement(using='css selector',"#main_pack > div.api_sc_page_wrap > div > a.btn_next")
  btn$clickElement()
  Sys.sleep(1)
}
write(reple, "newstitle.txt")
