library(httr)
library(rvest)
library(XML)

#1
searchUrl <- 'https://openapi.naver.com/v1/search/blog.xml'
Client_ID <- 'izGsqP2exeThwwEUVU3x'
Client_Secret <- 'WrwbQ1l6ZI'

query <- URLencode(iconv('맛집','euc-kr','UTF-8'))
url <- paste0(searchUrl, '?query=', query, '&display=100')
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))