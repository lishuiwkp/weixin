`library(network)
library(sna)
library(ggplot2)
library(ggnet)
### 方法1：
# random graph
net = rgraph(10, mode = "graph", tprob = 0.5)
net = network(net, directed = FALSE)

x = gplot.layout.fruchtermanreingold(net, NULL)
net %v% "x" = x[, 1]
net %v% "y" = x[, 2]

net %v% "t1" = c(0, 0, 0, 0, 0, 0, 1, 1, 1, 1)
net %v% "t2" = c(0, 0, 0, 0, 1, 1, 1, 1, 1, 1)
net %v% "t3" = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

net %v% "t1" = ifelse(net %v% "t1", 1, NA)
net %v% "t2" = ifelse(net %v% "t2", 1, NA)
net %v% "t3" = ifelse(net %v% "t3", 1, NA)

t1 = ggnet2(net, mode = c("x", "y"), size = 3, color = "black", na.rm = "t1")
t2 = ggnet2(net, mode = c("x", "y"), size = 3, color = "black", na.rm = "t2")
t3 = ggnet2(net, mode = c("x", "y"), size = 3, color = "black", na.rm = "t3")

par(mfrow=c(1,3))
plot(t1)
plot(t2)
plot(t3)
#### 实际操作层面，可以把多期网络的点同时加入，先用gplot.layout.fruchtermanreingold，
## 如果T期为出现则将对应的节点属性设置成“1”。


## 方法2：
## 问题：（1）前后两个网络规模必须相同，否则会报错
# （2）不能同时呈现两个以上网络
## 问题（1）可以尝试加入孤立点
library(migraph)
data(mpn_elite_mex)
net1 <- net %>% to_subgraph(t1 == 1)
net2 <- net %>% to_subgraph(t2 == 1)
net3 <- net %>% to_subgraph(t3 == 1)
net4 <- as_network(generate_permutation(net3))
network.size(net1)
network.size(net2)
network.size(net3)
network.size(net4)
plot(net1)
plot(net2)
plot(net3)
migraph::ggevolution(net1,net2)
migraph::ggevolution(net3,net4)

## 方法3：用network dynamic的思想实现动态图
## package：ndtv
## 暂未解决


## 方法4：用gephi绘制