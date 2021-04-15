library(readxl)
library(dplyr)

############################################
# 서울시 교통량(파일별로 변수 개수가 다를 수 있음)
############################################
car_jan <- read_xlsx("C:/Users/haoin/Rproject/data/1월 서울시 교통량 조사자료.xlsx", 2)
car_feb <- read_xlsx("C:/Users/haoin/Rproject/data/2월 서울시 교통량 조사자료.xlsx", 2)
car_mar <- read_xlsx("C:/Users/haoin/Rproject/data/3월 서울시 교통량 조사자료.xlsx", 2)
car_apr <- read_xlsx("C:/Users/haoin/Rproject/data/4월 서울시 교통량 조사자료.xlsx", 2)
car_may <- read_xlsx("C:/Users/haoin/Rproject/data/5월 서울시 교통량 조사자료.xlsx", 2)
car_jun <- read_xlsx("C:/Users/haoin/Rproject/data/6월 서울시 교통량 조사자료.xlsx", 2)
car_jul <- read_xlsx("C:/Users/haoin/Rproject/data/7월 서울시 교통량 조사자료.xlsx", 2)
car_aug <- read_xlsx("C:/Users/haoin/Rproject/data/8월 서울시 교통량 조사자료.xlsx", 2)
car_sep <- read_xlsx("C:/Users/haoin/Rproject/data/9월 서울시 교통량 조사자료.xlsx", 2)
car_oct <- read_xlsx("C:/Users/haoin/Rproject/data/10월 서울시 교통량 조사자료.xlsx", 2)
car_nov <- read_xlsx("C:/Users/haoin/Rproject/data/11월 서울시 교통량 조사자료.xlsx", 2)
car_dec <- read_xlsx("C:/Users/haoin/Rproject/data/12월 서울시 교통량 조사자료.xlsx", 2)
str(car_jan)
View(car_jan)
View(car_feb)

cars <- NULL

# 20190101 1시의 차량
car_jan %>% 
  filter(일자 == "20190101") %>% 
  select("1시") %>% 
  sum(na.rm=T) # sum(car_jan$1시, na.rm=T) 로 하면 모든 날 1시의 차량 수

# 20190101의 모든 통행량
car_jan %>% 
  filter(일자 == "20190101") %>% 
  select(-"요일", -"월", -"지점명", "방향", -"구분", -"지점번호", -"방향", -"일자") %>%
  sum(na.rm=T)

# 1월의 일별 교통량
cars <- rbind(cars, car_jan%>% mutate(sumall=rowSums(car_jan[,8:31], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>% 
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))


# 2월의 일별 교통량
cars <- rbind(cars, car_feb %>% mutate(sumall=rowSums(car_feb[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

colMeans(feb[,3]) # 2월 평균 교통량

# 3월의 일별 교통량
dim(car_mar)
cars <- rbind(cars, car_mar %>% mutate(sumall=rowSums(car_mar[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))


# 4월의 일별 교통량
dim(car_apr)
cars <- rbind(cars, car_apr %>% mutate(sumall=rowSums(car_apr[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 5월의 일별 교통량
dim(car_may)
cars <- rbind(cars, car_may %>% mutate(sumall=rowSums(car_may[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 6월의 일별 교통량
dim(car_jun)
cars <- rbind(cars, car_jun %>% mutate(sumall=rowSums(car_jun[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 7월의 일별 교통량
dim(car_jul)
cars <- rbind(cars, car_jul %>% mutate(sumall=rowSums(car_jul[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 8월의 일별 교통량
dim(car_aug)
cars <- rbind(cars, car_aug %>% mutate(sumall=rowSums(car_aug[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 9월의 일별 교통량
dim(car_sep)
cars <- rbind(cars, car_sep %>% mutate(sumall=rowSums(car_sep[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 10월의 일별 교통량
dim(car_oct)
cars <- rbind(cars, car_oct %>% mutate(sumall=rowSums(car_oct[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 11월의 일별 교통량
dim(car_nov)
cars <- rbind(cars, car_nov %>% mutate(sumall=rowSums(car_nov[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))

# 12월의 일별 교통량
dim(car_dec)
cars <- rbind(cars, car_dec %>% mutate(sumall=rowSums(car_dec[,7:30], na.rm = T)) %>%
                select("일자", "sumall") %>%
                mutate(요일 = format(as.Date(as.character(일자),format='%Y%m%d'), '%a')) %>%
                group_by(일자, 요일) %>%
                summarise(합계 = sum(sumall, na.rm=T)))



