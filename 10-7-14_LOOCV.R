library(ISLR)

attach(Auto)
names(Auto)

#using horsepower to determine MPG, what model is better?
#degree 1, 2, 3, etc.

#regular approach
#split the dataset into two parts
set.seed(1)
dim(Auto)

train = sample(1:392, 191)
test = -train

training_data = Auto[train,]
testing_data = Auto[test,]

testing_y = mpg[test]  #looking for MPG only at the test data

#Create a linear model of degree 1 (Linear = degree 1)
#y = a + b1x

model_l = lm(mpg ~ horsepower, training_data)

pred_y = predict(model_l, testing_data)

error = pred_y - testing_y
mse_l = mean(error^2)

mse_l

#create a quadratic model of degree 2

model_q = lm(mpg ~ poly(horsepower, 2), training_data)

pred_y = predict(model_q, testing_data)

error = pred_y - testing_y
MSE_q = mean(error^2)
MSE_q

#create models from degree 1 to 10
start = proc.time()
error = NULL
MSE = NULL

for( i in 1:10){
  model = lm(mpg ~ poly(horsepower, i), training_data)
  
  pred_y = predict(model, testing_data)
  
  error = pred_y - testing_y
  MSE[i] = mean(error^2)
 
    }

end = proc.time()

end - start

plot(1:10, MSE)
#best N = 5 = lowest MSE but overfit

#LOOCV Approach
library(boot)
#to run cross validation

#note we are using the whole data set as our training data
model_LOOCV = glm(mpg~horsepower, data = Auto)

#assess the model using cross validation

LOOCV_output = cv.glm(Auto,model_LOOCV)

names(LOOCV_output)

MSE_LOOCV = LOOCV_output$delta[1]
#[1] 24.23151

#Create 10 models of degrees 1 to 10

start = proc.time()
MSE_LOOCV = NULL
for(i in 1:10){
  model_LOOCV = glm(mpg~poly(horsepower,i)
                    ,data = Auto)
  #assess
  LOOCV_output = cv.glm(Auto,model_LOOCV)
  
  MSE_LOOCV[i] = LOOCV_output$delta[1]

}
end = proc.time()

end-start

plot(1:10, MSE_LOOCV, type = "l", #type = L lower cased
     xlab = "Degree",
     ylab = "MSE")

#create 10 models with K
#use 10-fold cross validation

set.seed(1)
start = proc.time()
MSE_10fold = NULL

for(i in 1:10){
  model_10fold = glm(mpg~poly(horsepower,i)
                    ,data = Auto)
  #assess
  k10fold_output = cv.glm(Auto,model_10fold,K=10)
  
  MSE_10fold[i] = k10fold_output$delta[1]
  
}
end = proc.time()

end-start

plot(1:10, MSE_10fold, type = "l", #type = L lower cased
     xlab = "Degree",
     ylab = "MSE")




