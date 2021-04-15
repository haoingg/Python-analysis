library(RSelenium)
library(dplyr)
library(RColorBrewer)
library(showtext)
library(extrafont)
showtext_auto() 

font_add(family = 'black', regular = 'fonts/BlackHanSans.ttf')
font_add(family = 'gothic', regular = 'fonts/GothicA1.ttf')
font_add(family = 'dog', regular = 'fonts/THEdog.ttf')

# [미세먼지]
#미세먼지 PM-10 (㎍/m3)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("https://cleanair.seoul.go.kr/statistics/dayAverage")

#측정물질 - 미세먼지로 변경
dust <- remDr$findElements(using='css selector', '#pollutantType > option:nth-child(2)')
sapply(dust, function(x){x$clickElement()})
Sys.sleep(0.5)

#2019년 결과값
nineteenyear <- remDr$findElements(using='css selector', '#lGroup > option:nth-child(3)') #2019년 선택
sapply(nineteenyear, function(x){x$clickElement()})
Sys.sleep(0.5)

#월
day <- NULL; day2 <- NULL; day3 <- NULL
day <-  remDr$findElements(using='css selector', '#day-table > thead > tr:nth-child(2) > th')
day2 <- sapply(day, function(x) {x$getElementText()})
day3 <- append(day3, unlist(day2))
day4 <- day3[-1]

finedust <- NULL; finedust2 <- NULL; finedust3 <- NULL; finedust4 <- NULL;　n <- 1; dustdata <- 1

#월 변화 결과값
for (i in 1:12) {
  months <- remDr$findElements(using='css selector', paste0('#monthList > option:nth-child(',i,')'))
  sapply(months, function(x){x$clickElement()})
  Sys.sleep(0.5)
  
  #검색 버튼 클릭
  btn <- remDr$findElements(using='css selector', '#search')
  sapply(btn, function(x){x$clickElement()})
  Sys.sleep(0.5)
  
  #서울시 일별 평균 미세먼지
  finedust <- remDr$findElements(using='css selector', '#day-table > tbody > tr.total> td:nth-child(n + 3)')
  finedust2 <- sapply(finedust, function(x) {x$getElementText()})
  finedust3 <- rbind(finedust3, as.numeric(unlist(finedust2)))
  }

rownames(finedust3)<-c('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월')
colnames(finedust3) <-c(paste0(1:31, '일'))
finedust3 <- t(finedust3) #행렬 순서 전환
finedust3 <- as.data.frame(finedust3) #dplyr 패키지 사용 위해 타입 변경
finedust4 <- round(colMeans(finedust3, na.rm=T), 2) #반올림 한 월 평균
finedust4 <- rbind(finedust3, finedust4)
rownames(finedust4)[32] <- '월 평균'
View(finedust4)
write.csv(finedust4, "data/미세먼지.csv")
# ================
# [초미세먼지]
#초미세먼지 PM-2.5 (㎍/m3)

#측정물질 - 초미세먼지로 변경
dusts <- remDr$findElements(using='css selector', '#pollutantType > option:nth-child(1)')
sapply(dusts, function(x){x$clickElement()})
Sys.sleep(0.5)

#월
days <- NULL; days2 <- NULL; days3 <- NULL
days <-  remDr$findElements(using='css selector', '#day-table > thead > tr:nth-child(2) > th')
days2 <- sapply(days, function(x) {x$getElementText()})
days3 <- append(days3, unlist(days2))
days4 <- days3[-1]

ultrafinedust <- NULL; ultrafinedust2 <- NULL; ultrafinedust3 <- NULL; ultrafinedust4 <- NULL;　n <- 1; ultradustdata <- 1

#월 변화 결과값
for (i in 1:12) {
  months <- remDr$findElements(using='css selector', paste0('#monthList > option:nth-child(',i,')'))
  sapply(months, function(x){x$clickElement()})
  Sys.sleep(0.5)
  
  #검색 버튼 클릭
  btn <- remDr$findElements(using='css selector', '#search')
  sapply(btn, function(x){x$clickElement()})
  Sys.sleep(0.5)
  
  #서울시 일별 평균 초미세먼지
  ultrafinedust <- remDr$findElements(using='css selector', '#day-table > tbody > tr.total> td:nth-child(n + 3)')
  ultrafinedust2 <- sapply(ultrafinedust, function(x) {x$getElementText()})
  ultrafinedust3 <- rbind(ultrafinedust3, as.numeric(unlist(ultrafinedust2)))
  }

rownames(ultrafinedust3)<-c('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월')
colnames(ultrafinedust3) <-c(paste0(1:31, '일'))
ultrafinedust3 <- t(ultrafinedust3) #행렬 순서 전환
ultrafinedust3 <- as.data.frame(ultrafinedust3) #dplyr 패키지 사용 위해 타입 변경
ultrafinedust4 <- round(colMeans(ultrafinedust3, na.rm=T), 2) #반올림 한 월 평균
ultrafinedust4 <- rbind(ultrafinedust3, ultrafinedust4)
rownames(ultrafinedust4)[32] <- '월 평균'
View(ultrafinedust4)
write.csv(ultrafinedust4, "data/초미세먼지.csv")

# ================
# [2019 비교 그래프]
finedust5 <-as.character(finedust4[32,])
ultrafinedust5 <-as.character(ultrafinedust4[32,])

plot(finedust5, type='o', ann=F, xaxt='n',
     ylim=c(0, 100), lwd=2 , cex=1, col='#FF4900EF') #lwd 선 굵기 , cex 점 굵기
title(main='2019년 초/미세먼지 월별 농도 변화', cex.main=1.5, family = 'black')
axis(1, 1:12, paste0(1:12, seq='월'), cex=0.8, family = 'gothic')
text(finedust5, finedust5, pos=3, cex=0.7, family = 'gothic')
lines(ultrafinedust5, type='o', ann=F, lwd=2 , cex=1, col='#008EFFFF', text(ultrafinedust5, ultrafinedust5, pos=1, cex=0.7))
legend(9,96, c('미세먼지', '초미세먼지'), cex=0.8, pch=c(16, 21), lty=c(1,2), col=c('#FF4900EF','#008EFFFF'), box.lty=0
       )

dev.copy(png, width=690, 'output/dustcomparsion1.png')
dev.off()

#boxplot
finedust6 <- boxplot(finedust3[,1], finedust3[,2], finedust3[,3],
        finedust3[,4], finedust3[,5], finedust3[,6],
        finedust3[,7], finedust3[,8], finedust3[,9],
        finedust3[,10], finedust3[,11], finedust3[,12],
        names=c('1월', '2월', '3월', '4월', '5월', '6월',
                '7월', '8월', '9월', '10월', '11월', '12월'), ylim=c(0,150), col='lightblue')
title(main='2019년 초/미세먼지 월별 농도 변화', family='black', cex.main=1.5)

dev.copy(png, width=800, 'output/dustcomparsion3.png')
dev.off()
# ================
# [주별 미세먼지 분석]

#최대 129.1
finedust_max <- finedust4[1:7, 3]; mean(finedust_max) #3월 1일~5일
#최소 45.9
finedust_min <- finedust4[18:24, 3]; mean(finedust_min)#3월 18일~24일

# [평일/주말 미세먼지 분석]

result1 <- result %>% filter(!(요일 == "토" | 요일 =="일")) #주중
result1 <- as.data.frame(result1); result1

dust_weekday <- result1[, 5]
dust_weekday2 <- round(mean(dust_weekday), 2);dust_weekday2 #주중 미세먼지 평균 42.4
ultra_weekday <- result1[, 6]
ultra_weekday2 <- round(mean(ultra_weekday), 2);ultra_weekday2 #주중 초미세먼지 평균 24.69

result2 <- result %>% filter((요일 == "토" | 요일 =="일")) #주말
result2 <- as.data.frame(result2); result2

dust_weekend <- result2[, 5]
dust_weekend2 <- round(mean(dust_weekend), 2);dust_weekend2 #주말 미세먼지 평균 41.41
ultra_weekend <- result2[, 6]
ultra_weekend2 <- round(mean(ultra_weekend), 2);ultra_weekend2 #주말 초미세먼지 평균 24.69

result1 <- rbind(dust_weekday2, dust_weekend2); result1
result2 <- rbind(ultra_weekday2, ultra_weekend2); result2

pie(result1, main='미세먼지 주중/주말 비교', labels=c('주중', '주말'), family = 'black')

dev.copy(png, width=400, 'output/pie1.png')
dev.off()

pie(result2, main='초미세먼지 주중/주말 비교', labels=c('주중', '주말'), family = 'black')

dev.copy(png, width=400, 'output/pie2.png')
dev.off()

# ================
# [2000년~2020년 연도별 미세먼지 분석]

#측정물질 - 미세먼지로 변경
dust <- remDr$findElements(using='css selector', '#pollutantType > option:nth-child(2)')
sapply(dust, function(x){x$clickElement()})
Sys.sleep(0.3)

years <- NULL; years2 <- NULL; years3 <- NULL; years4 <- NULL;　n <- 1;

#월 변화 결과값
for (i in 2:22) {
  year <- remDr$findElements(using='css selector', paste0('#lGroup > option:nth-child(',i,')'))
  sapply(year, function(x){x$clickElement()})
  Sys.sleep(0.3)
  
  for (i in 1:12) {
    months <- remDr$findElements(using='css selector', paste0('#monthList > option:nth-child(',i,')'))
    sapply(months, function(x){x$clickElement()})
    Sys.sleep(0.3)
    
   #검색 버튼 클릭
    btn <- remDr$findElements(using='css selector', '#search')
    sapply(btn, function(x){x$clickElement()})
    Sys.sleep(0.3)
    
    #서울시 일별 평균 미세먼지
    years <- remDr$findElements(using='css selector', '#day-table > tbody > tr.total > td:nth-child(2)')
    years2 <- sapply(years, function(x) {x$getElementText()})
    years3 <- rbind(years3, as.numeric(unlist(years2)))
  }}; years3

allyear <- data.frame('00'=years3[1:12,],
                      '01'=years3[13:24,],
                      '02'=years3[25:36,],
                      '03'=years3[37:48,],
                      '04'=years3[49:60,],
                      '05'=years3[61:72,],
                      '06'=years3[73:84,],
                      '07'=years3[85:96,],
                      '08'=years3[97:108,],
                      '09'=years3[109:120,],
                      '10'=years3[121:132,],
                      '11'=years3[133:144,],
                      '12'=years3[145:156,],
                      '13'=years3[157:168,],
                      '14'=years3[169:180,],
                      '15'=years3[181:192,],
                      '16'=years3[193:204,],
                      '17'=years3[205:216,],
                      '18'=years3[217:228,],
                      '19'=years3[229:240,],
                      '20'=years3[241:252,])

allyear2 <- round(colMeans(allyear, na.rm=T),2)
allyear3 <- rbind(allyear, allyear2)
rownames(allyear3)[13] <- '연도별 평균'

View(allyear3)
write.csv(allyear3, "data/00~20년 미세먼지.csv")

#연도별 그래프
allyear4 <-as.numeric(allyear3[13,])
max(allyear4); min(allyear4) #76.3, 35.3

mypb <- barplot(allyear4, names=c('00년', '01년', '02년', '03년', '04년', '05년', '06년', '07년', '08년', '09년', '10년',
                          '11년', '12년', '13년', '14년', '15년', '16년', '17년', '18년', '19년', '20년'),
        space=1, width=3, col='#A8FF00FF', ylim=c(0,90), family = 'gothic',
        border='white')
text(x=mypb, y=allyear4, labels=allyear4, pos=3, cex=0.6, family = 'gothic', 
)
title(main='연도별 미세먼지 평균 농도', family = 'black', cex.main=2)

dev.copy(png, height=500, width=1200, 'output/dustcomparsion2.png')
dev.off()
