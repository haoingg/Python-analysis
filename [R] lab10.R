library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = 'localhost', port = 4445, browserName= 'chrome')
remDr$open()

url <- 'https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2'
remDr$navigate(url)

Sys.sleep(3)

pageLink <- NULL
reple <- NULL
curr_PageOldNum <- 0

repeat{
  doms <- remDr$findElements(using = 'css selector', '.txt ng-binding')
  Sys.sleep(1)
  reple_v <- sapply(doms, function(x) {x$getElemtntText()})
  print(reple_v)
  reple <- append(reple, unlist(reple_v))
  cat(length(reple), '\n')
  
  pageLink <- remDr$findElements(using = 'css selector', '')
  
}

