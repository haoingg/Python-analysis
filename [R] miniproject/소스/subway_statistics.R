############################################
# 지하철 탑승객 인원
############################################
library(readxl)
library(dplyr)

subway <- read_xlsx("C:/Users/haoin/Rproject/data/2019년 지하철 승하차인원.xlsx", 1)
str(subway)
View(subway)

subway %>% rename("합계" = "합 계") -> subway

#(sumsub <- rowSums(subway[,6:25], na.rm = T)) # 합계 열을 사용해도 됨

# 날짜별 지하철 승객 합계
subway %>% 
  select("날짜", "합계") %>% 
  mutate(요일 = format(as.Date(as.character(날짜),format='%Y%m%d'), '%a')) %>%
  group_by(날짜, 요일) %>%
  summarise(sum=sum(합계, na.rm=T)) -> subways

