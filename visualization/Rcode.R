setwd("E:\\Office Account\\2023\\visualization")
### 网络可视化的几种方式
library(networkdata)
library(migraph)
net1 <- networkdata::law_advice
summary(networkdata::law_advice)
# 
##
###计算节点的度
library(igraph)
deg <- degree(net1,mode="all")


#####igraph包####
plot(net1)

plot(net1,vertex.size=0.3*deg,
     vertex.label.cex=0.8,vertex.label.dist=1,
     edge.color="gray50",edge.arrow.size=0.2, edge.curved=0.1,
     layout = layout_nicely)

plot(net1,vertex.size=0.3*deg,
     vertex.label.cex=0.8,vertex.label.dist=1,
     edge.color="gray50",edge.arrow.size=0.2, edge.curved=0.1,
     layout = layout_with_graphopt)

#####sna包#####
library(sna)
net2 <- as_network(net1)
class(net2)
gplot(net2)
gplot(net2,mode = "fruchtermanreingold", vertex.cex = 0.05*deg)
gplot(net2,mode = "kamadakawai", vertex.cex = 0.05*deg)


#####networkD3包#####
library(networkD3)
wc <- cluster_walktrap(net1)
members <- membership(wc)
net3 <- igraph_to_networkD3(net1,group = members)
forceNetwork(Links = net3$links,Nodes = net3$nodes,
             Source = 'source', Target = 'target', NodeID = 'name',
             Group = 'group',opacity = 1)

#####netplot包####
# install.packages("netplot")
library(netplot)
l <- layout_with_fr(net1)
nplot(net1,layout = l)


####GGally包#####
# install.packages("GGally")
library(GGally)
ggnet(net2, label = TRUE, alpha = 1, color = "white", segment.color = "black")


####ggnetwork包#####
# install.packages("ggnetwork")
library(ggnetwork)
class(net2)
ggnetwork(net2)
ggplot(ggnetwork(net2),aes(x = x,y = y,xend = xend, yend = yend)) + 
  geom_edges(color = "grey50") + 
  geom_nodes(aes(color = gender,size = law_school))+
  theme_blank()

####snahelper包#####
library(snahelper)
library(ggraph)
x <- c(-0.2245, 0.8126, 1.2537, 0.4038, -0.0849, 0.334, 1.439, -1.1675, 0.6242, 0.5051, -0.7435,
    0.4281, -0.4488, 1.2982, 0.8881, 0.7482, 0.4317, 0.4058, 0.7211, 0.094, -0.6422, -0.265, -0.6402,
    -0.1926, 1.4567, -0.1274, -0.2278, 0.6259, 0.1924, 0.4892, -0.0191, 0.5635, 0.1533, 0.6193, 0.9636,
    -0.1174, 1.616, -0.5164, -1.0102, -1.2044, -0.6313, 0.19, -0.6495, 1.6184, 0.9558, 1.5048, 0.7229,
    0.2023, -1.5533, 0.8026, -0.5046, -1.2541, 0.5967, -1.1922, -0.9628, -0.9498, -1.3808, -0.3994,
    -0.0777, 1.1958, 1.0676, -0.2128, 1.2621, -0.038, -0.8515, -0.7746, -1.6599, -1.275, -1.1968,
    -0.3678, -1.8116)
y <- c(-0.6299, 0.5967, -0.9242, -0.1678, -1.3405, -0.8852, 0.3035, 0.2478, 1.0663, 1.2892, -0.5855,
    0.4416, -2e-04, -0.181, -0.1493, 0.3559, 0.1455, -1.6612, 0.1808, -0.3191, 0.1659, -0.2395, -1.0834,
    0.4913, -0.3802, 0.0897, 0.3461, -0.3446, 0.8387, -0.7706, -1.0071, -1.0361, -0.7594, 0.7707,
    -0.6047, -0.3337, 0.1774, 0.6821, -0.4878, 0.1229, -0.2882, 0.3688, 0.7806, 0.953, 0.9252, -0.0694,
    -1.4756, 1.1754, -0.44, -0.8127, -0.8266, -0.3732, 1.6883, -0.7291, -0.1551, 0.5421, 0.6293,
    -1.3591, -1.8689, 0.7182, 1.9475, 1.2749, -1.2288, 1.3398, 0.042, 0.4541, 0.4617, 0.7108, 1.0771,
    1.0577, 0.0124)

ggraph(net1, layout = "manual", x = x, y = y) + 
	 geom_edge_link0(edge_colour = "#A8A8A8", edge_width = 0.8,
    edge_alpha = 1, arrow = arrow(angle = 30, length = unit(0.15, "inches"), ends = "last", type = "closed")) + 
    geom_node_point(fill = "#525252", colour = "#000000", size = 5, stroke = 0.3, shape = 21) + 
	 theme_graph() + 
    theme(legend.position = "none")

####migraph包####
library(migraph)
migraph::autographr(net1)
