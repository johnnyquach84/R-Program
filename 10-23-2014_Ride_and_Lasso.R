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

y = Hitters$Salary

# split the dataset into training and testing 









