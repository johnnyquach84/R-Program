library(ISLR)
library(glmnet)
?Carseats


### Question #1
x <- model.matrix(Sales~., Carseats)
x = x[,-1] #get rid of the intercept column (1st column)
head(x)

y <- na.omit(Carseats$Sales)

###split data

set.seed(1)

train = sample(1:nrow(x), 300)
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

### Question #2
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
model_coef
