library(rvest)

news.title <- NULL
news.company <- NULL
text <- NULL
page <- NULL

site <- 'http://media.daum.net/ranking/popular/'
text <- read_html(site, encoding='UTF-8')

for (index in 1:50) {
  #title
  ntitle <- html_nodes(text, paste0('#mArticle > div.rank_news > ul.list_news2 > li:nth-child(', index, ') > div.cont_thumb > strong > a'))
  title <- html_text(ntitle)
  news.title[index] <- title
  #company
  ncompany <- html_nodes(text, paste0('#mArticle > div.rank_news > ul.list_news2 > li:nth-child(', index, ') > div.cont_thumb > strong > span'))
  company <- html_text(ncompany)
  news.company[index] <- company
}
page <- data.frame(news.title, news.company)
View(page)
write.csv(page, 'output/newspaper.csv')












