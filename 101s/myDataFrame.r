age_<-c(22,34,29,25,30,33,31,27,25,25)
time_<-c(14.21,10.36,11.09,13.01,12.03,10.99,12.48,13.37,12.29,11.92)
sex_<-c("H","H","H","M","M","H","M","M","H","H")

myData <- data.frame(age_,time_,sex_)
myData

c('a','b') 
str(myData)
dim(myData)
myData[,1]
myData[1,]
myData$age_[3]

dat <-myData$time_ >=12
dat
val <- which(dat)
val
myData[val,]

my_file<- read.csv("/home/eduardoubuntu/Documents/Platzi/R/R_Data_Science_Course/iris-data.csv")
my_file

View(my_file)
iris
