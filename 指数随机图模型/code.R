##************************************************
# 指数随机图模型示例
# 作者：wkp
# 参考文献：Harris J K. An introduction to exponential random graph modeling[M]. Sage, 2013.
# 依赖包：
# (1)network：导入数据
# (2)sna:可视化
# (3)ergm:建模
# 也可以直接加载statnet包
##************************************************

# 设定路径
setwd("E:\\Office Account\\GitHub\\指数随机图模型\\code.R")
# 加载包
library(network)
library(sna)
library(ergm)
library(readxl)
## Step1:导入数据
data1 <- read_xlsx("data1.xlsx")
data1 <- as.matrix(data1)
# 利用network包将原始数据转化为network对象
net1 <- as.network(data1,directed = F)
class(net1)
# 简单的描述统计：度数分布
summary(net1 ~ degree(1) + degree(2) + degree(3))
# 利用sna包的gplot函数进行可视化，默认的可视化方式是fruchtermanreingold
# 默认的可视化方式是fruchtermanreingold,可以调整mode参数进行更改
# 另外：gmode参数指定--单向、无向,具体可以参照sna包gplot函数
gplot(net1,gmode = "graph")
# Step2:建模
# (1)基准模型
model1 <- ergm(net1 ~ edges,
               control=control.ergm(MCMC.samplesize=100000, 
                                    MCMC.burnin=1000000, 
                                    MCMC.interval=1000, 
                                    seed = 567))
summary(model1)

# (2)加入内生结构项
# 注：网络内生项可以根据模型调试加入，也可以通过模体分析再加入
model2 <- ergm(net1 ~ edges + gwesp(0.1,T),
               control=control.ergm(MCMC.samplesize=100, 
                                    MCMC.burnin=100, 
                                    MCMC.interval=100, 
                                    seed = 567))
summary(model2)
# (3)加入节点属性
node_attr <- read_xlsx("patent.xlsx")
net2 <- network(net1,vertex.attr = node_attr,
                vertex.attrnames = "patent",
                directed = F)
summary(net2)
model3 <- ergm(net2 ~ edges + gwesp(0.1,T) + nodecov("patent"),
               control=control.ergm(MCMC.samplesize=100, 
                                    MCMC.burnin=100,  
                                    MCMC.interval=100,
                                    seed = 567))
summary(model3)

# (4)加入外生协变量
tech_proximity <- read_xlsx("tech_proximity.xlsx",col_names = T)
tech_proximity <- as.matrix(tech_proximity)
net2 %e% "tech_proximity" <- tech_proximity
summary(net2)
model4 <- ergm(net2 ~ edges + gwesp(0.1,T) + 
               nodecov("patent") + edgecov(tech_proximity),
               control=control.ergm(MCMC.samplesize=100, 
                                    MCMC.burnin=100,  
                                    MCMC.interval=100,
                                    seed = 567))
summary(model4)
# 模型有效性检验
# (1)拟合优度检验
# 以model4为例
model4_gof <- gof(model4,GOF = ~ degree + espartners+ dspartners,
                  verbose = T, burnin = 10000,
                  interval = 10000)
par(mfrow = c(2,3),mar = c(4,4,4,1),cex.main = .9,cex.lab = .9,cex.axis = .75)
plot(model4_gof,plotlogodds = T)
# (2)MCMC检验
mcmc.diagnostics(model4)
## 至此指数随机图模型的三类变量都依次加入模型中
# 模型整理
library(texreg)
screenreg(list(model1,model2,model3,model4),digits = 3)
