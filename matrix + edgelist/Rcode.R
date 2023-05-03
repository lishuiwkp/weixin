## 从网络对象中提取matrix或edgelist
# 生成示例数据
library(igraph)
library(migraph)
library(intergraph)
library(network)
ring_net <- make_ring(10)
class(ring_net)

set.seed(123)
m <- matrix(rbinom(25,1,.4),5,5)
diag(m) <- 0
net <- as.network(m,directed = T)
class(net)
####从igraph对象中提取matrix或edgelist
# 方法1：igraph包
matrix1 <- igraph::as_adjacency_matrix(ring_net)
matrix1
edgelist1 <- igraph::as_edgelist(ring_net)
edgelist1
# 方法2：migraph包
matrix2 <- migraph::as_matrix(ring_net)
matrix2
edgelist2 <- migraph::as_edgelist(ring_net)
edgelist2
# 方法3：intergraph包
matrix3 <- intergraph::asDF(ring_net)
matrix3

####从network对象中提取matrix或edgelist
# 方法1：network包
matrix1_1 <- network::as.matrix.network(net) 
matrix1_1
edgelist1_1 <- network::as.matrix.network.edgelist(net)
edgelist1_1
# 方法2：migraph包
matrix2_1 <- migraph::as_matrix(net)
matrix2_1
edgelist2_1 <- migraph::as_edgelist(net)
edgelist2_1
