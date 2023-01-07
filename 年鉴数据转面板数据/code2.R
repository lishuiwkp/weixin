##************************************************
# 年鉴数据转面板数据示例（适用于多变量）
# 作者：wkp
##************************************************
# 设置路径
setwd("E:\\Office Account\\GitHub\\年鉴数据转面板数据")
# 加载包，读取数据
library(readxl)
library(reshape2)
library(dplyr)
data.gdp <- read_xlsx("data.xlsx",sheet = 1)
data.rks <- read_xlsx("data.xlsx",sheet = 2)
data.lse <- read_xlsx("data.xlsx",sheet = 3)
# 数据融合及排序
data.gdp1 <- melt(data = data.gdp,
              id.vars = c("ID","INDEX"),
              measure.vars = c("2006","2007","2008","2009","2010",
                               "2011","2012","2013","2014","2015",
                               "2016","2017","2018","2019"))
data.gdp2 <- arrange(data.gdp1,data.gdp1$INDEX)

data.rks1 <- melt(data = data.rks,
                  id.vars = c("ID","INDEX"),
                  measure.vars = c("2006","2007","2008","2009","2010",
                                   "2011","2012","2013","2014","2015",
                                   "2016","2017","2018","2019"))
data.rks2 <- arrange(data.rks1,data.rks1$INDEX)

data.lse1 <- melt(data = data.lse,
                  id.vars = c("ID","INDEX"),
                  measure.vars = c("2006","2007","2008","2009","2010",
                                   "2011","2012","2013","2014","2015",
                                   "2016","2017","2018","2019"))
data.lse2 <- arrange(data.lse1,data.lse1$INDEX)
# 数据合并
data.merge <- cbind(data.gdp2,data.rks2,data.lse2)
# 确认数据是否有误
View(data.merge)
# 删除多余变量及修改变量名
data.merge <- data.merge[,-c(5,6,7,9,10,11)]
data.merge <- rename(data.merge,GDP=value,rks=value.1,lse=value.2)
