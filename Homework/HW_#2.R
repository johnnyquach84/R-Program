### Assignment two. Categorical values to predict the Y variable

library(ISLR)
?OJ

library(class)
### Latex to produce pdf file from Rstudio

#1-A: Investigate about the OJ dataset.
#   : Describe it, and state how many obs and vars are there.

dim(OJ)
## This shows 1070 observation with 18 variables

names(OJ)
## Verified the 18 variables

head(OJ)
#The data shows who purchased OJ, what week, what store, what price
##The discount they got, the Loyalty channel, the sales price, distribution

#Overall, the dataset provides an extensive amount of data in regards to
## the purchase of the OJ

#2-A: Create a testing dataset containing the first 200 obs
#   : A testing dataset containing the remaining obs
#   : Fit a KNN model  (k=1) for classification with Purchase
#   : Random number generator to 1  using set.seed(1)
#   : What is the misclassification error rate for the model?  Answer =  .215

#Testing Dataset containing 200 obs
Testing_1 = 1:200

#Dataset with remaining obs
Training_1 = -Testing_1

#KNN Model (K=1)  ## No Categorical Values
set.seed(1)

new_oj = OJ[,-c(3,8,9,14,18)]

std_oj = scale(new_oj[,-1])

Test_Data = std_oj[Testing_1,]
Test_Purchase = new_oj[Testing_1,1]

Train_Data = std_oj[Training_1,]
Train_Purchase = new_oj[Training_1,1]

## Fit Model

Predicted_Purchase = knn(Train_Data, Test_Data, Train_Purchase, k = 1)

mean(Predicted_Purchase != Test_Purchase)

## C - Create a Loop of 100 to identify best K

error = NULL
for(i in 1:100){
  set.seed(1)
  Predicted_Purchase = knn(Train_Data, Test_Data, Train_Purchase, k = i)
  error[i] = mean(Predicted_Purchase != Test_Purchase)  ### != not equal logical test  
}

error

min_error_rate = min(error)
min_error_rate

k = which(error == min_error_rate) ### Identify which K is best for the model to lower error rate


#C - Answer
#1. The best minimal error rate for my model is 0.145 with a K of 7

#D - Question: Create a plot that shows how misclassification error changes for the 100 values of K
library(ggplot2)
qplot(1:100, error)


