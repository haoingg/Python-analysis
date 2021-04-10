# 문제1
exam1 <- function(){
  x <- paste0(LETTERS, letters)
  return(x)
}; x

# 문제2
exam2 <- function(x){
  xx <- x
  return(sum(1:xx))
}; exam2(5)

# 문제3
exam3 <- function(x, y){
  if(x>=y){
    return(x-y)
  }else {return(y-x)}
}; exam3(6, 3)
  
# 문제4
exam4 <- function(x, y, z){
  if(y == '+'){
    cal = x + z
  }else if(y == '-'){
    cal = x - z
  }else if(y == '*'){
    cal = x * z
  }else if(y == '%/%'){ 
    cal = x %/% z
    if(x == 0){
      cal = "오류1"
  }else if(y == '%%'){
    cal = x %% z
    if(x == 0){
      cal = "오류2"
    }
  }else{
    cal = "규격의 연산자만 전달하세요"
  }}
  return(cal)
}; exam4(3, "+", 2)

# 문제5 - X
exam5 <- function(x, y= TRUE){
  num <-x
  sen <- y
  if(x<=0){
    cat()
  }else if(num == TRUE){
    cat(rep("#",count))
  }else{
    cat(rep(sen,count))
  }
}


# 문제6 - X
exam6 <- function(score){
  if(score <= 100){
    grade = print("상")
    }else if(score <= 84){
    grade = print("중")
    }else if(score <= 69){
      grade = print("하")
    }else(score = "NA"){
      grade = print("NA는 처리불가")
    }{print(score, "점은", grade, "등급입니다.")
      }}

exam6(102)