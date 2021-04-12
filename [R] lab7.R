library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)
text

#1 태그의 컨텐츠
node1 <- html_nodes(text, "h1")
node1
title <- html_text(node1)
title

#2 태그의 href 속성값
node2 <- html_nodes(text, "a")
html_attr(node2, "href")

#3 <img> 태그의 src 속성값
node3 <- html_nodes(text, "img")
html_attr(node3, "src")

#4 첫 번째 <h2> 태그의 컨텐츠
node4 <- html_nodes(text, "h2")
node4
title2 <- html_text(node4)
title2[1]

#5 <ul> 태그의 자식 태그들 중 style 속성의 값이 green으로 끝나는 태그의 컨텐츠 -?
node5 <- html_nodes(text, "ul>li[style$='green'")
green1 <- html_text(node5)
green1
 
#6 두 번째 <h2> 태그의 컨텐츠
node6 <- html_nodes(text, "h2")
node6
title3 <- html_text(node6)
title3[2]

#7 <ol> 태그의 모든 자식 태그들의 컨텐츠
node7 <- html_nodes(text, "ol")
html_text(node7)
content1 <- gsub("[[:cntrl:]]", " ", node7)
content1

#8 <table> 태그의 모든 자손 태그들의 컨텐츠
node8 <- html_nodes(text, "table")
content2 <- html_text(node8)
content2

#9 name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
node9 <- html_nodes(text, "tr.name")
content3 <- html_text(node9)
content3

#10 target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
node10 <- html_node(text, "td#target")
content4 <- html_text(node10)
content4
