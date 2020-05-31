#* @param opinions
#* @param price
#* @param weight
#* @param batteries.required
#* @param length
#* @param width
#* @param height
#* @get /getCluster
function(opinions,price,weight,batteries.required, length, width, height){
  campos <- as.vector(data[1,])
  #b <- dist(c(1,2,3,4,5,6))
  #b
  mydist <- matrix(0,ncol=8,nrow=7)
  for(i in 1:7){
    c <- dist(x = c(campos[i],mycluster$centers[,i]))
    b <- as.matrix(c)
    distance<-b[-1,1]
    mydist[i,] <- distance
  }
  rownames(mydist) <- colnames(mycluster$centers)
  
  total_dist <- apply(mydist, 2, sum)
  total_dist
  
  num_cluster <- which.min(total_dist)
  num_cluster
}



