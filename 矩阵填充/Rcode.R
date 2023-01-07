library(openxlsx)
setwd("E:\\Office Account\\GitHub\\矩阵填充")
# 
small <- read.xlsx("data.xlsx",sheet = 1,rowNames = T)
# 方法1--循环语句
# 设置大矩阵的列名、行名
BIG <- matrix(0,nrow = 5,ncol = 5)
names_big <- c("A","B","C","D","E")
colnames(BIG) <- names_big
rownames(BIG) <- names_big

n <- ncol(small)
names_small <- colnames(small)
for (i in 1:n){
  for (j in 1:n){
    c <- which(colnames(BIG) == names_small[i]) # 大矩阵等于小矩阵
    d <- which(rownames(BIG) == names_small[j])
    
    BIG[d,c] <- small[j,i]
  }
}




# 方法2--匹配位置
BIG <- matrix(0,nrow = 5,ncol = 5)
names_big <- c("A","B","C","D","E")
colnames(BIG) <- names_big
rownames(BIG) <- names_big
loc <- match(rownames(small),rownames(BIG))
loc
BIG[loc,loc] <- as.matrix(small)
BIG