library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

remDr$navigate("http://gs25.gsretail.com/gscvs/ko/products/event-goods")
Sys.sleep(3)

#2+1 이동
twoplusone <- remDr$findElements(using='css selector', '#TWO_TO_ONE')
envent <- sapply(twoplusone, function(x){x$clickElement()})

goodsname <- NULL; goodsprice <- NULL;
name <- NULL; price <- NULL;

repeat{
#상품이름
eventgoodsname <- remDr$findElements(using='css selector','#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit')
name <- sapply(eventgoodsname, function(x) {x$getElementText()})
goodsname <- append(goodsname, unlist(name))

#상품가격
eventgoodsprice <- remDr$findElements(using='css selector','#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
price <- sapply(eventgoodsprice, function(x) {x$getElementText()})
goodsprice <- append(goodsprice, unlist(price))

#페이지이동
btn <- remDr$findElement(using = "css selector", "#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next")
#btn$getElementText()
btn$clickElement()
Sys.sleep(3)
}

gs25_twotoone <- data.frame(goodsname=unlist(goodsname), goodsprice=unlist(goodsprice))
View(gs25_twotoone)

write.csv(gs25_twotoone, "output/gs25_twotoone.csv")
