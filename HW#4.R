#scale data, load data, careful of categorical data

#load data
winedata = read.csv(file ="winedata.csv")

attach(winedata)

head(winedata)
vars(winedata)
names(winedata)
dim(winedata)

round(cor(winedata[,-12]), digit = 2)

dim(winedata)

#(a) Randomly choose 1000 obs for training
set.seed(1)
test = sample(1:nrow(winedata),1000) #sample will create a vector 1 to 400
train = -test

training_data = winedata[train,]
testing_data = winedata[test,]

# select the y (good / bad) from the testing data

testing_y = testing_data[, 12]

# Logic = create training data and testing data, create training_y columnn

# (b) Fit a logistic regression model

model = glm(quality~., 
            data = training_data,
            family = "binomial")  #glm () used for logistic and regression

summary(model)

## Assess the model

predicted_probs = predict(model, 
                          testing_data, 
                          type ="response")
head(predicted_probs)

contrasts(quality)

# Initialize Y_hat with a vector full of good
y_hat = rep("not good", length(testing_y)) #Length takes a vector

y_hat[predicted_probs < 0.5] = "good"  #anything below <0.5, we change it to "not good"

# Find the Mean square error

mean(testing_y != y_hat)

table(testing_y, y_hat)

# table(testing_y, y_hat)
#testing_y  good      not good
#good       610       66
#not good   168       156
> 
confusionMatrix(testing_y,y_hat)

#(b)-> b. What is the sensitivity of the model?
    # 0.7841
#(b)-> c. What is the misclassification error rate for the model?
    # mean(testing_y != y_hat)
    # 0.234

#(c) Fit LDA using all predictor variables in the training dataset.
  
  #LDA
library(MASS) #Load Mass to enable LDA and QDA 
lda_model = lda(quality~.,
                data = training_data)
summary(lda_model)  

pred_lda = predict(lda_model, testing_data)
pred_lda #this provided the category already with the predict model
names(pred_lda)

pred_lda_y = pred_lda$class #selecting just class from data frame

# Confusion matrix
table(pred_lda_y, testing_y)

#misclassification error
mean(pred_lda_y != testing_y)
  
#sensitivity of model
confusionMatrix(pred_lda_y,testing_y)

#(c) -> b-c

#confusion matrix
# table(pred_lda_y, testing_y)
#            testing_y
#pred_lda_y good     not good
#good       614      169
#not good   62       155

#misclassification error
#mean(pred_lda_y != testing_y)
#0.231

#sensitivity of the model
#.9083


library(caret)
library(ggplot2)

install.packages("e1071")

#(d) Fit QDA using all predictor variables 
library(MASS) #Load Mass to enable LDA and QDA 
qda_model = qda(quality~.,
                data = training_data)
summary(qda_model)

pred_qda = predict(qda_model, testing_data)
pred_qda #this provided the category already with the predict model
names(pred_qda)

pred_qda_y = pred_qda$class #selecting just class from data frame

# Confusion matrix
table(pred_qda_y, testing_y)
# testing_y
#pred_qda_y good not good
#good      578      153
#not good   98      171


#misclassification error
mean(pred_qda_y != testing_y)
# 0.251

#confusionMatrix + sensitivity
confusionMatrix(pred_qda_y, testing_y)
#sens = .8550

plot(Lag5)

library(class) #to run KNN function #no assumptions
#must scale the data when using KNN.

names(winedata)
head(winedata)
newwine = scale(winedata[,-c(12)])

head(newwine)

#(a) Randomly choose 1000 obs for training
set.seed(1)
knntest = sample(1:nrow(winedata),1000) #sample will create a vector 1 to 400
knntrain = -knntest

knntraining_data = scale(winedata[knntrain,-c(12)])
knntesting_data = scale(winedata[knntest,-c(12)])

knntesting_y = winedata[knntest,12]
knntraining_y = winedata[knntrain,12]

#Run KNN
set.seed(1)
knn_predicted_y = knn(knntraining_data, knntesting_data,
                      knntraining_y, k = 1)

mean(knn_predicted_y != knntesting_y) 
#MSE = 0.195

table(knn_predicted_y, knntesting_y)

confusionMatrix(knn_predicted_y, knntesting_y)
