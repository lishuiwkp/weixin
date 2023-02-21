setwd("E:/Office Account/GitHub/diagnose multicollinearity in ERGM")
set.seed(21093)
library(ergm)
library(ergMargins)
data("faux.mesa.high")
data("faux.dixon.high")
my.ergm2<-ergm(faux.mesa.high~edges+
                 gwesp(0.1,T)+
                 nodecov("Grade")+
                 nodefactor("Race")+
                 nodefactor("Sex")+
                 nodematch("Grade")+
                 nodematch("Sex")+
                 nodematch("Race"))
vif.ergm(my.ergm2)
