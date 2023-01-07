setwd("E:\\Office Account\\GitHub\\social network analysis in R")
library(statnet)
library(igraph)
library(network)
library(readxl)
library(openxlsx)
# 导入数据的几种方式
bfriend <- as.matrix(read.table("Freeman_w2b.txt"))
bfriend2 <- read_xlsx("data.xlsx",sheet = 1) 
bfriend3 <- read.xlsx("data.xlsx",sheet = 2,rowNames = T)

# 导入网络的几种方式
bfriendNet <-  as.network(bfriend, directed = T)
bfriendNet2 <- graph_from_adjacency_matrix(bfriend,mode = "directed")

# 描述网络
# igraph
V(bfriendNet2) # 32个节点
E(bfriendNet2) # 204条边
edge_density(bfriendNet2) # 0.2056452
# network
network.density(bfriendNet) # 0.2056452
network.edgecount(bfriendNet) # 204条边
network.size(bfriendNet) # 32个节点

# 可视化
gplot(bfriendNet) # network
plot(bfriendNet2,
     vertex.color = "green",
     edge.arrow.size = 0.1,
     layout = layout.fruchterman.reingold) # igraph
