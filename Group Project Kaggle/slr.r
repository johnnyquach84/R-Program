rm(list = ls())
setwd("~/kaggle/AfSIS")
library(caret)

train <- read.csv('training.csv', header = TRUE)
test <- read.csv('sorted_test.csv',header = TRUE)
train$Depth <-  with ( train, ifelse ( ( Depth == 'Subsoil' ), 0 , 1 ) )
test$Depth <-  with ( test, ifelse ( ( Depth == 'Subsoil' ), 0 , 1 ) ) 

Xtrain <- train[,2:3595]
Ytrain <- train[,3596:3600]
Xtest <- test[,2:3595]
IDtest <- test[,1]


#delete highly correlated (>0.95) features.
tooHigh <- findCorrelation(cor(rbind(Xtrain,Xtest)), .95)

Xtrainfiltered <- Xtrain[, -tooHigh]
Xtestfiltered  <-  Xtest[, -tooHigh]

set.seed(1)
# 10 fold cv
indx <- createFolds(Ytrain[,1], returnTrain = TRUE)
ctrl <- trainControl(method = "cv", index = indx)

#predict Ca
lmTuneCa <- train(x = Xtrainfiltered, y = Ytrain$Ca,
                 method = "lm",
                 trControl = ctrl)
lmTuneCa
#RMSE = 0.409
testResults <- data.frame(PIDN = IDtest,
                          Ca = predict(lmTuneCa, Xtestfiltered))

#predict P
lmTuneP <- train(x = Xtrainfiltered, y = Ytrain$P,
                  method = "lm",
                  trControl = ctrl)
lmTuneP
#RMSE = 0.925
testResults$P <- predict(lmTuneP,Xtestfiltered)

#predict pH
lmTunepH <- train(x = Xtrainfiltered, y = Ytrain$pH,
                 method = "lm",
                 trControl = ctrl)
lmTunepH
#RMSE = 0.508
testResults$pH <- predict(lmTunepH,Xtestfiltered)

#predict SOC
lmTuneSOC <- train(x = Xtrainfiltered, y = Ytrain$SOC,
                  method = "lm",
                  trControl = ctrl)
lmTuneSOC
#RMSE = 0.511
testResults$SOC <- predict(lmTuneSOC,Xtestfiltered)

#predict Sand
lmTuneSand <- train(x = Xtrainfiltered, y = Ytrain$Sand,
                   method = "lm",
                   trControl = ctrl)
lmTuneSand
#RMSE = 0.495
testResults$Sand <- predict(lmTuneSand,Xtestfiltered)

write.csv(testResults,file = "slr.csv",row.names = FALSE)
