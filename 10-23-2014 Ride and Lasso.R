# This code is to run ridge and lasso regression in R

library(ISLR)
library(glmnet)

glmnet() #alpha = ridge (0) or lasso (1)

#glmnet needs 4 arguments
# x: matrix
# y = vector
# alpha = 0 or 1
# lambda = a set of lambda values

