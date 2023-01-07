setwd("E:\\Office Account\\GitHub\\矩阵型数据与Source-Target型数据互转")
library(network)
library(igraph)
library(openxlsx)
# 矩阵型数据导入
data1 <- read.xlsx("data.xlsx",rowNames = T)
data1 <- as.matrix(data1)
net1 <- as.network(data1,directed = T)
edgelist <- as.matrix.network.edgelist(net1)

# Source-Target型数据导入
net2 <- graph_from_edgelist(edgelist, directed = TRUE)
summary(net2)
net2.edge.matrix <- as_adjacency_matrix(net2)
matrix <- as.matrix(net2.edge.matrix)