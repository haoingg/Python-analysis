library(MASS)
library(psych)
library(corrplot)
library(corrgram)

data('airquality')
str(airquality)
?airquality

#결측치 행 제거
airquality <- airquality[complete.cases(airquality), ] #NA가 아닌 데이터 값들을 모두 꺼냄

#상관계수(p<0.05)
corr.test(airquality)
# => Wind와 Solar.R 0.18

cor.test(airquality$Wind, airquality$Solar.R)

#1
pairs(airquality)
dev.copy(png, 'output/lab20_1.png')
dev.off()

#2
pairs.panels(airquality, bg='red', pch=21, hist.col='gold',
             main='Correlation Plot of airquality Data')
dev.copy(png, "output/lab20_2.png")
dev.off()

#3
corrplot(cor(airquality), method='pie', type='lower', order='hclust', addCoef.col = 'black', tl.srt=45, diag=F)
dev.copy(png, 'output/lab20_3.png')
dev.off()



