setwd("E:\\Office Account\\2023\\network只显示部分标签")
library(openxlsx)
library(network)
library(migraph)
library(sna)
library(igraph)
data <- matrix(c(0,1,0,1,1,0,1,0,0,1,0,1,1,0,1,0),byrow = TRUE,nrow = 4,
               dimnames = list(c("A", "B", "C", "D"), c("A", "B", "C", "D")))

## 准备两个网络，一个是net（network），一个是graph（igraph）
net <- as.network(data)
net %v% "label" <- c("A","B","C","D")
graph <- as_igraph(net)

node <- c("A","B","C")
## network
gplot(net,label = ifelse(net %v% "label" %in% node,net %v% "label",""),
      label.cex = 0.5,
      vertex.col = "grey",
      mode = "kamadakawai")

## igraph
plot(graph,vertex.label = ifelse(V(graph)$label %in% node, V(graph)$label,""),
     vertex.label.cex=1,
     vertex.label.dist=1,
     edge.color="gray50",
     edge.arrow.size=0.02, 
     edge.curved=0.1,
     layout = layout_with_kk)
