# 문제1
L1 <- list(
  name="scott",
  sal = 3000
); L1

result1 <- L1[["sal"]] * 2; result1

# 문제2
L2 <- list(
  "scott",
  seq(100, 200, 300)
); L2

# 문제3
L3 <- list(
  c(3, 5, 7), c("A", "B", "C")
  )
L3[[2]][1] <- "Alpha"; L3

# 문제4
L4 <- list(
  alpha=0:4,
  beta=sqrt(1:5),
  gamma=log(1:5)
)
L4[[1]] + 10

# 문제5
L5 <- list(
  data1=LETTERS,
  data2=emp(1:3,),
  data3=L4
); L5

L5[[1]][1]
L5[[2]]$ename
L5[[3]][[3]]

# 문제6
L6 <- list(
  math=list(95, 90),
  writing=list(90, 85),
  reading=list(85, 80)
)
mean(unlist(L6))

# 문제7
grade <- sample(1:6, 1)
if(grade == 1 | grade == 2 | grade == 3){
  cat(grade, "학년은 저학년입니다.","\n")
}else{
  cat(grade,"학년은 고학년입니다.","\n")
}

# 문제8
choice <- sample(1:5, 1)
if(choice == 1){
  msg = (300+50)
}else if(choice == 2){
  msg = (300-50)
}else if(choice == 3){
  msg = (300*50)
}else if(choice == 4){
  msg = (300/50)
}else{
  msg = (300%%50)
}
cat("결과값 :", msg)

# 문제9
count <- sample(3:10, 1)
deco <- sample(1:3, 1)
if(deco==1){
  for(i in 1: count)
    cat("*")
}else if(deco==2){
  for(i in 2: count)
    cat("$")
}else{
  for(i in 3: count)
    cat("#")
}


# 문제10
score <- sample(0:100, 1)
if(score>=90){
  level = "A 등급"
}else if (score>=80){
  level = "B 등급"
}else if (score>=70){
  level = "C 등급"
}else if (score>=60){
  level = "D 등급"
}else {
  level = "F 등급"
}
score <- paste(score, "점은", level, "등급입니다.", sep="")

# 문제11
alpha <- paste0(LETTERS, letters); alpha










