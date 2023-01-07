setwd("E:\\Office Account\\GitHub\\R语言-技术邻近性")
library(readxl)
X <- read_xlsx("tech.xlsx",sheet = 1)

Consine=matrix(data=0,nrow =dim(X)[1],ncol = dim(X)[1])
for (i in 1:dim(X)[1])
  for (j in 1:dim(X)[1])
    Consine[i,j] = sum(t(X[i,])*X[j,])/sqrt((sum(X[i,]^2))*sum(X[j,]^2))