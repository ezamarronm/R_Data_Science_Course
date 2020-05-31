data <-read.csv("vacuums.csv")
#rownames(data) <- data[,1]
data <- data[,-1]
data <- data[,-1]
data$Opinions <- as.numeric(data$Opinions)
data$Batteries.Required <- as.numeric(data$Batteries.Required)
data <- scale(data)

mycluster <- kmeans(data,3,nstart =5,iter.max = 30)
#mycluster$iter
#mycluster$size
#mycluster$centers
#mycluster$withinss

wss <- (nrow(data)-1) * sum(apply(data,2,var))

for (i in 2:20) wss[i] <- sum(kmeans(data,centers = i)$withinss)
wss
plot(1:20,wss,type = "b",xlab = "Clusters Number", ylab = "Withinss groups")

########
mycluster <- kmeans(data,8,nstart =5,iter.max = 30)
mycluster
library(fmsb)

#Plotting
par(mfrow = c(2,4))
for (x in 1:8) {
  dat <- as.data.frame(t(mycluster$centers[x, ]))
  dat <-rbind(rep(5,10), rep(-1.5,10),dat)
  radarchart(dat) 
}

#dat <- as.data.frame(t(mycluster$centers[1, ]))
#dat <-rbind(rep(5,10), rep(-1.5,10),dat)
#radarchart(dat) 
#dat <- as.data.frame(t(mycluster$centers[2, ]))
#dat <-rbind(rep(5,10), rep(-1.5,10),dat)
#radarchart(dat) 