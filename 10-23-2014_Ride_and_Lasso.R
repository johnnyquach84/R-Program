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

#as lambda increase, coefficient shrinks

ridge_model$lambda[50]
ridge_model$lambda[60]

#compare the coefficients for both lambda
log(2378)
log(938)
#we took log because x axis is the log

coef(ridge_model)[,50]
coef(ridge_model)[,60]

#cross validation, two line code to get the best lambda
#weaker predict = closer to zero

#choose the best value of lambda that would
#minmize the MSE / error rate
#run cross validation (cv.glmnet)

set.seed(1)
cv_error = cv.glmnet(training_x,
                     training_y,
                     alpha = 0)
cv_error

best_lambda = cv_error$lambda.min

best_lambda

#our final ridge
model_coef = predict(ridge_model,
                     type = "coefficient",
                      s = best_lambda) #s = Lambda

model_coef

#test the model

predicted_y = predict(ridge_model,
                      s = best_lambda,
                      newx = testing_x) #choose x
#MSE
mean((predicted_y - testing_y)^2)


#LASSO

lasso_model = glmnet(training_x,
                     training_y,
                     alpha = 1)

plot(lasso_model, xvar =  "lambda")


set.seed(1)
cv_error = cv.glmnet(training_x,
                     training_y,
                     alpha = 1)

best_lambda = cv_error$lambda.min

best_lambda


predicted_y = predict(lasso_model,
                      s = best_lambda,
                      newx = testing_x) #choose x

#MSE 
mean((predicted_y - testing_y)^2)

#Lasso Coefficients
model_coef = predict(lasso_model,
                     type = "coefficient",
                     s = best_lambda) #s = Lambda

#run ridge regression all values of lambda
#run cross validation to find best lambda
#build your model based on best lambda (coefficients)

#linear regression

linear_model = lm(Salary~., data = Hitters[train,])

predicted_y = predict(linear_model, Hitters[test,])

testing_y = na.omit(Hitters$Salary[test])

mean((predicted_y - testing_y)^2)
