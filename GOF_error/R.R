setwd("E:/Office Account/2023/GOF_error")
library(openxlsx)
tech1 <- read.xlsx("tech_proximity.xlsx",rowNames = T,sheet = 1)
tech1 <- as.matrix(tech1)
tech2 <- read.xlsx("tech_proximity.xlsx",sheet = 2)
tech2 <- as.matrix(tech2)
library(network)
library(sna)
library(ergm)
library(btergm)

net1 <- read.xlsx("sub1.xlsx",rowNames = T,sheet = 1)
net2 <- read.xlsx("sub1.xlsx",rowNames = F,sheet = 2)
net1 <- as.matrix(net1)
net2 <- as.matrix(net2)

net1 <- as.network(net1,directed = F)
net2 <- as.network(net2,directed = F)

## model1：包含行名的因变量 + 包含行名的X
model1 <- ergm(net1 ~ edges + edgecov(tech1))
## model2：包含行名的因变量 + 不包含行名的X
model2 <- ergm(net1 ~ edges + edgecov(tech2))
## model3：不包含行名的因变量 + 包含行名的X
model3 <- ergm(net2 ~ edges + edgecov(tech1))
## model4：不包含行名的因变量 + 不包含行名的X
model4 <- ergm(net2 ~ edges + edgecov(tech2))

summary(model1)
summary(model2)
summary(model3)
summary(model4)

gof1 <- btergm::gof(model1,nsim = 100,
           statistics = c(esp, dsp, geodesic, deg, triad.undirected, rocpr),
           verbose = T, burnin = 10000,
           interval = 10000,seed = 567)
plot(gof1)

gof2 <- btergm::gof(model2,nsim = 100,
            statistics = c(esp, dsp, geodesic, deg, triad.undirected, rocpr),
            verbose = T, burnin = 10000,
            interval = 10000,seed = 567)
plot(gof2)

gof3 <- btergm::gof(model3,nsim = 100,
                    statistics = c(esp, dsp, geodesic, deg, triad.undirected, rocpr),
                    verbose = T, burnin = 10000,
                    interval = 10000,seed = 567)
plot(gof3)

gof4 <- btergm::gof(model4,nsim = 100,
                    statistics = c(esp, dsp, geodesic, deg, triad.undirected, rocpr),
                    verbose = T, burnin = 10000,
                    interval = 10000,seed = 567)
plot(gof4)
