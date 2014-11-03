# Fitting Logistic Regression
# Predict The Stock Market

library(ISLR)
attach(Smarket)

?Smarket

head(Smarket)

round(cor(Smarket[,-9]), digit = 2)
dim(Smarket)

?cor

pairs(Smarket[,-9])


# Split the data into training (2001 - 2004)
# and testing (2005)

#training data should always be bigger than testing

train = (Smarket$Year < 2005)
test = !train #  ! = Opposite of true

training_data = Smarket[train,-8]
testing_data = Smarket[test,-8]

# select the y (direction) from the testing data

testing_y = testing_data[,8]


# Logic = create training data and testing data, create training_y columnn

# Fit a logistic regression model

model = glm(Direction ~., 
            data = training_data,
            family = "binomial")  #glm () used for logistic and regression

#(formula = predicting Direction from everything ~.)
# family = binomial = for logistic regression

summary (model)

# Assess the model

predicted_probs = predict(model,
                          testing_data,
                          type = "response")  #response = probability

head(predicted_probs)

# identify what does 0 and 1 means by using contrasts()

contrasts(Direction)
 
# Up is 1 and Down is 0
# Probability of Y = 1.  So the chances of it going up.
# If the Down was = 1, then the probability of it going down.

# We need to create a new vector of Ups and Downs
# Based on the predicted probabilities, Use a threshold of 0.5

# Initialize Y_hat with a vector full of Ups
y_hat = rep("Up", length(testing_y)) #Length takes a vector

y_hat[predicted_probs < 0.5] = "Down"  #anything below <0.5, we change it to "down"

a = c(2,4,-3,5,-4,9)

a>0

a[a>0] = "New"
a

# Find the Mean square error

mean(testing_y != y_hat)

table(testing_y, y_hat) #confusion matrix will explain MSE
#           Y_hat
#testing_y Down  Up
#Down       2   109       #vertical columns = y_hat = prediction   
#Up         1   140       #


#LDA
library(MASS) #Load Mass to enable LDA and QDA 
lda_model = lda(Direction~.,
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

#QDA
library(MASS) #Load Mass to enable LDA and QDA 
qda_model = qda(Direction~.,
                data = training_data)
summary(qda_model)

pred_qda = predict(qda_model, testing_data)
pred_qda #this provided the category already with the predict model
names(pred_qda)

pred_qda_y = pred_qda$class #selecting just class from data frame

# Confusion matrix
table(pred_qda_y, testing_y)

#misclassification error
mean(pred_qda_y != testing_y)

#if QDA and LDA about the same, it means that our data is more linear and variance is closer

plot(Lag1)

#variance is about the same between all the lag1-lag5

# KNN 
library(class) #to run KNN function #no assumptions
#must scale the data when using KNN.
names(Smarket)
data = scale(Smarket[,-c(1,8,9)]) #scaled our data and removed certain columns

train = (Smarket$Year < 2005)
test = !train #  ! = Opposite of true

training_data = scale(Smarket[train,-c(1,8,9)])
testing_data = scale(Smarket[test,-c(1,8,9)])

# select the y (direction) from the testing data

testing_y = Smarket[test,9]  #direction only from test data

training_y = Smarket[train,9]

#Run KNN
set.seed(1)
knn_predicted_y = knn(training_data, testing_data,
                training_y, k = 10)

mean(knn_predicted_y != testing_y) #MSE = .49% MEAN = Classification rate okay

#mse = nonclassification error rate

