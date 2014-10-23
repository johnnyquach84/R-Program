# This code is to run ridge and lasso regression in R

library(ISLR)
library(glmnet)

glmnet() #alpha = ridge (0) or lasso (1)

#glmnet needs 4 arguments
# x: matrix
# y = vector
# alpha = 0 or 1
# lambda = a set of lambda values

# prepare the data


x = model.matrix(Salary~., Hitters)
head(x)

x = x[,-1] #get rid of the intercept column (1st column)

# model.matrix transform the data into a matrix
# and it deletes observation with missing values
# this transform categorical vars into dummy variables (lasso / riddge can't take categorical values)

y = na.omit(Hitters$Salary) #remove na from matrix

# split the dataset into training and testing 
set.seed(1)

train = sample(1:nrow(x), nrow(x)/2)
test = -train

training_x = x[train,]
testing_x = x[test,]

training_y = y[train] #no need for , since its already a vector - no two dimensions
testing_y = y[test]


# define lambda

lambda_grid = seq(0, 10^10, length = 100)

#ridge regression

ridge_model = glmnet(training_x,
                     training_y,
                     alpha = 0)
              

plot(ridge_model, xvar =  "lambda")

