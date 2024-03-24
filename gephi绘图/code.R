setwd("E:\\Office Account\\2024\\gephi绘图")
library(readxl)
data <- read_xls("geo_cepii.xls")
data <- data[,c(4,10,12,13)]
data_unique <- data[!duplicated(data$country), ]

num_rows <- 100
simulated_data <- data.frame(
  from = sample(data_unique$country, num_rows, replace = TRUE),
  to = sample(data_unique$country, num_rows, replace = TRUE),
  weight = sample(1:10, num_rows, replace = TRUE)  
)

write.csv(simulated_data,file = "from_to_weight.csv")
write.csv(data_unique,file = "data_unique.csv")
