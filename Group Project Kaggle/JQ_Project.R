testdata <- read.csv("sorted_test.csv")
trainingdata <- read.csv("training.csv")

names(trainingdata)

soil_properties <- c("Ca", "P", "pH", "SOC", "Sand")

x <- model.matrix(soil_properties~., testdata)

library(glmnet)

#load data and remove CO2 bands
trainingdata <- read.csv("training.csv")
trainingdata <- trainingdata[,-(2656:2670)]

#create N colors ranging from green to red
colfunc <- colorRampPalette(c('green','yellow', 'red'))
cols <- colfunc(nrow(data))

#Ranks are used to give the colors to the lines
ranks <- rank(trainingdata[,'SOC'], ties.method='first')

#matplot plots columns, so take transpose first
matplot(t(trainingdata[,2:3564]), type='l', col=cols[ranks], lwd=0.2)

#Create Log Regression; family="binomial"
glmmodel <- glm(formula, data=trainingdata, family ="binomial")


