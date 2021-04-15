library(dplyr)
############################################
# 교통량과 지하철 탑승객 자료 통합
############################################
cars %>% rename(날짜 = "일자", 교통량="합계") -> cars
subways %>% rename(탑승객=sum) -> subways
result <- cbind(cars, subways[,3])
head(result)

############################################
# result와 미세먼지, 초미세먼지 자료 통합
############################################
dust <- finedust3
dust1<-as.vector(dust[,1])
dust1 <- append(dust1, dust[,2])
dust1 <- append(dust1, dust[,3])
dust1 <- append(dust1, dust[,4])
dust1 <- append(dust1, dust[,5])
dust1 <- append(dust1, dust[,6])
dust1 <- append(dust1, dust[,7])
dust1 <- append(dust1, dust[,8])
dust1 <- append(dust1, dust[,9])
dust1 <- append(dust1, dust[,10])
dust1 <- append(dust1, dust[,11])
dust1 <- append(dust1, dust[,12])

dust2 <- dust1[complete.cases(dust1)]
result <- cbind(result, dust2)
result %>% rename(미세먼지=...5) -> result


dust <- ultrafinedust3
dust1 <- as.vector(dust[,1])
dust1 <- append(dust1, dust[,2])
dust1 <- append(dust1, dust[,3])
dust1 <- append(dust1, dust[,4])
dust1 <- append(dust1, dust[,5])
dust1 <- append(dust1, dust[,6])
dust1 <- append(dust1, dust[,7])
dust1 <- append(dust1, dust[,8])
dust1 <- append(dust1, dust[,9])
dust1 <- append(dust1, dust[,10])
dust1 <- append(dust1, dust[,11])
dust1 <- append(dust1, dust[,12])

dust2 <- dust1[complete.cases(dust1)]
result <- cbind(result, dust2)
result %>% rename(초미세먼지=...6) -> result
result %>% head

############################################
# 통합된 자료 분석
############################################
library(car)
cor(result$교통량, result$탑승객) 
cor.test(result$교통량, result$탑승객) 

#cor.test(~ 미세먼지 + 탑승객, 교통량, 초미세먼지, data=result)
cor(result[,3:6])
# 결정계수는 전체적으로 0.8 이상
# 
result.lm <- lm(미세먼지~날짜+교통량+탑승객+초미세먼지, data=result)
result.lm <- lm(초미세먼지~미세먼지+탑승객+교통량, data=result)
summary(result.lm)

vif(result.lm) # 모두 10이 넘지 않아 다중공선성은 없다.


############################################
# 비상저감조치 교통량, 탑승객 비교
############################################
result_weekend <- result %>%
  filter(초미세먼지 >= 50 & (요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
  summarise("교통량 주말 평균" = mean(교통량), "탑승객 주말 평균"=mean(탑승객))
result_weekend <- cbind(result_weekend, result %>%
                          filter(초미세먼지 < 50 & (요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
                          summarise("교통량 주말 평균" = mean(교통량), "탑승객 주말 평균"=mean(탑승객)))
  
result_weekday <- result %>%
  filter(초미세먼지 >= 50 & !(요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
  summarise("교통량 평일 평균" = mean(교통량), "탑승객 평일 평균"=mean(탑승객))
result_weekday <- cbind(result_weekday, result %>%
                          filter(초미세먼지 < 50 & !(요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
                          summarise("교통량 평일 평균" = mean(교통량), "탑승객 평일 평균"=mean(탑승객)))

result_weekday<-round(result_weekday/1000)
result_weekend<-round(result_weekend/1000)

names(result_weekday) <- c("비상저감조치시 교통량", "비상저감조치시 지하철", "일반 교통량", "일반 지하철")
names(result_weekend) <- c("비상저감조치시 교통량", "비상저감조치시 지하철", "일반 교통량", "일반 지하철")

pm <- barplot(as.matrix(result_weekday), 
        main="미세먼지 농도에 따른 평일 교통량, 탑승객 평균",
        ylim=c(9000,11000), xpd=F)
text(x=pm, y=result_weekday, labels=result_weekday, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over50weekday.png')
dev.off()

pm <- barplot(as.matrix(result_weekend), 
        main="미세먼지 농도에 따른 주말 교통량, 탑승객 평균",
        ylim=c(6500,9000), xpd=F)
text(x=pm, y=result_weekend, labels=result_weekend, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over50weekend.png')
dev.off()


pm <- barplot(as.numeric(result_weekday), 
              main="미세먼지 농도에 따른 평일 교통량, 탑승객 평균",
              ylim=c(9000,11000), xpd=F, border='white',
              col=c('lightblue1','lightsalmon2', 'lightblue1', 'lightsalmon2'),
              names=c('비상저감조치시 교통량', '비상저감조치시 지하철', '일반 교통량', '일반 지하철'))
text(x=pm, y=result_weekday, labels=result_weekday, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over50weekday.png')
dev.off()


pm <- barplot(as.numeric(result_weekend), 
              main="미세먼지 농도에 따른 주말 교통량, 탑승객 평균",
              ylim=c(6500,9000), xpd=F, border='white',
              col=c('lightblue1','lightsalmon2', 'lightblue1', 'lightsalmon2'),
              names=c('비상저감조치시 교통량', '비상저감조치시 지하철', '일반 교통량', '일반 지하철'))
text(x=pm, y=result_weekend, labels=result_weekend, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over50weekend.png')
dev.off()

############################################
# 미세먼지 나쁨(75이상) 교통량, 탑승객 비교
############################################
result_weekend <- result %>%
  filter(초미세먼지 >= 75 & (요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
  summarise("75이상 교통량" = mean(교통량), "75이상 지하철"=mean(탑승객))
result_weekend <- cbind(result_weekend, result %>%
                          filter(초미세먼지 < 50 & (요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
                          summarise("일반 교통량" = mean(교통량), "일반 지하철"=mean(탑승객)))

result_weekday <- result %>%
  filter(초미세먼지 >= 75 & !(요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
  summarise("75이상 교통량" = mean(교통량), "75이상 지하철"=mean(탑승객))
result_weekday <- cbind(result_weekday, result %>%
                          filter(초미세먼지 < 50 & !(요일 == "토" | 요일 =="일")) %>% select(교통량, 탑승객) %>%
                          summarise("일반 교통량" = mean(교통량), "일반 지하철"=mean(탑승객)))

result_weekday<-round(result_weekday/1000)
result_weekend<-round(result_weekend/1000)

#names(result_weekday) <- c("75이상 교통량", "75이상 지하철", "일반 교통량", "일반 지하철")
#names(result_weekend) <- c("75이상 교통량", "75이상 지하철", "일반 교통량", "일반 지하철")

pm <- barplot(as.matrix(result_weekday), 
              main="미세먼지 농도에 따른 평일 교통량, 탑승객 평균",
              ylim=c(9000,11000), xpd=F)
text(x=pm, y=result_weekday, labels=result_weekday, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over75weekday.png')
dev.off()

pm <- barplot(as.matrix(result_weekend), 
              main="미세먼지 농도에 따른 평일 교통량, 탑승객 평균",
              ylim=c(6000,9000), xpd=F)
text(x=pm, y=result_weekend, labels=result_weekend, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over75weekend.png')
dev.off()



pm <- barplot(as.numeric(result_weekday), 
              main="미세먼지 농도에 따른 평일 교통량, 탑승객 평균",
              ylim=c(9000,11000), xpd=F, border='white',
              col=c('lightblue1','lightsalmon2', 'lightblue1', 'lightsalmon2'),
              names=c('75이상 교통량', '75이상 지하철', '일반 교통량', '일반 지하철'))
text(x=pm, y=result_weekday, labels=result_weekday, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over75weekday.png')
dev.off()


pm <- barplot(as.numeric(result_weekend), 
              main="미세먼지 농도에 따른 주말 교통량, 탑승객 평균",
              ylim=c(6000,9000), xpd=F, border='white',
              col=c('lightblue1','lightsalmon2', 'lightblue1', 'lightsalmon2'),
              names=c('75이상 교통량', '75이상 지하철', '일반 교통량', '일반 지하철'))
text(x=pm, y=result_weekend, labels=result_weekend, pos=3, cex=1, family = 'gothic')

dev.copy(png, width=850, 'output/over75weekend.png')
dev.off()



############################################
# 미세먼지, 교통량/탑승객 산포도
############################################
library(ggplot2)

plot(result$초미세먼지,                        # x축 자료
     result$교통량/1000,                         # y축 자료
     main='미세먼지와 교통량',     # 그래프 제목
     xlab='초미세먼지',                       # x축 레이블
     ylab='교통량',                   # y축 레이블
)
dev.copy(png, width=850, 'output/dustandcar.png')
dev.off()


plot(result$초미세먼지,                        # x축 자료
     result$탑승객/1000,                         # y축 자료
     main='미세먼지와 지하철 이용객',     # 그래프 제목
     xlab='초미세먼지',                       # x축 레이블
     ylab='지하철 이용객',                   # y축 레이블
)
dev.copy(png, width=850, 'output/dustandsub.png')
dev.off()



