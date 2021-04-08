# 문제1
v1 <- c(1:10)
v2 <- v1*2
max.v <- max(v2)
min.v <- min(v2)
avg.v <- mean(v2)
sum.v <- sum(v2)
v3 <- v2[-5]

print(v1)
print(v2)
print(max.v)
print(min.v)
print(avg.v)
print(sum.v)
print(v3)

# 문제2
v4 <- (1:5*2 -1)
v5 <- rep(1,5)
v6 <- rep(1:3, 3)
v7 <- rep(1:4, each=2)

print(v4)
print(v5)
print(v6)
print(v7)

# 문제3
nums <- sample(1:100, 10)
sort(nums)
sort(nums, decreasing = TRUE)
nums[nums>50]
nums[nums<=50]
max(nums);min(nums)

#문제4
v8 <- seq(1,10,3)
names(v8) <- c("A", "B", "C", "D")
print(v8)

#문제5
score <- sample(1:20, 5)
myFriend <- c("둘리","또치","도우너","희동","듀크")

paste(score, myFriend, sep="-")
max(myFriend)
min(myFriend)
myFriend[which(score> 10)]

#문제6
count <- sample(1:100, 7)
week.korname <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일")

paste(count, week.korname, sep=":")
max(week.korname)
min(week.korname)
week.korname[which(count>50)]









