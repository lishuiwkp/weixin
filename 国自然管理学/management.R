#install.packages("jiebaRD")
#install.packages("jiebaR")
#install.packages("wordcloud2")
library(jiebaRD) 
library(jiebaR)                 
library(wordcloud2)
setwd("E:\\Office Account\\2024\\国自然管理学")
# 先将一段文字转成词频
text = read.table("df.txt")
text <- as.character(text)
initialize = worker(stop_word="baidu_stopwords.txt")
# 停止词文件可以在这里下载https://www.bioladder.cn/shiny/zyp/bioladder2/demoData/wordcloud/stopwords.txt
df<-freq(initialize[text]) # 计算词频

# 绘图
wordcloud2(df, 
           size = 1,                  # 字体大小
           fontFamily = 'Segoe UI',   # 字体
           fontWeight = 'bold',       # 字体粗细
           color = 'random-dark',     # 字体颜色
           backgroundColor = "white", # 背景颜色
           minRotation = -pi/4,       # minRotation和maxRotation控制文本旋转角度的范围
           maxRotation = pi/4,
           rotateRatio = 0.4,         # 文本旋转的概率 0.4表示大约有40%的词发生了旋转
           shape = "circle"           # 轮廓形状
)
