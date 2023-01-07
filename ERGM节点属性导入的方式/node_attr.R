library(statnet)
# 生成示例数据
data <- matrix(c(1:9),nrow = 3, ncol = 3)
diag(data) <- 0
net <- as.network(data,directed = T)
summary(net)
# 导入节点属性
X1 <- as.data.frame(c(1,5,10))
X2 <- as.data.frame(c(12,0.1,31))
X3 <- as.data.frame(c(0,1,0))
attr <- as.data.frame(cbind(X1,X2,X3))

# 方法1
# 注：这里的net[i]可以都是net，代码运行他是会覆盖上去的。
net1 <- network(net,vertex.attr = X1,
                    vertex.attrnames = "X1",
                    directed = T)
net2 <- network(net1,vertex.attr = X2,
               vertex.attrnames = "X2",
               directed = T)
net3 <- network(net2,vertex.attr = X3,
               vertex.attrnames = "X3",
               directed = T)
summary(net3)

# 方法2
net4 <- set.vertex.attribute(net,"X1",attr[,1])
net5 <- set.vertex.attribute(net4,"X2",attr[,2])
net6 <- set.vertex.attribute(net5,"X3",attr[,3])
summary(net6)

# 方法3
net %v% "X1" <- attr[,1]
net %v% "X2" <- attr[,2]
net %v% "X3" <- attr[,3] 
summary(net)
