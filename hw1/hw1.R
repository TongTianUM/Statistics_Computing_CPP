library(Rcpp)
sourceCpp("/Users/tong/Desktop/tonytian_hw1a.cpp")
sizes=c(1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000)
funcs <- c("insertion_sort","bubble_sort","merge_sort","std_sort","sort")
df <- data.frame() 
for(func in funcs) {
  prevtime=0 
  for(sz in sizes) {
    if ( prevtime < 10 ) { 
      x <- rnorm(sz) 
      t <- max(system.time(x <- do.call(func,list(x)))[1],0.001)
      df <- rbind(df, data.frame(size=sz, func=func, time=t, min=x[1],max=x[sz])) 
      prevtime <- t
    } 
  }
}
library(ggplot2)
pdf("plot.pdf",width=8,height=5)
print(ggplot(df,aes(x=size,y=time,colour=func))+geom_point()+geom_line()+sca le_x_log10()+scale_y_log10())
dev.off()
print(df)