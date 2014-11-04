library(MASS)
head(fgl)

set.seed(1)

y <- na.omit(fgl$type)

train = sample(1:nrow(fgl), 150)
test = -train

training_data = fgl[train,]
testing_data = fgl[test,]

training_y = y[train] #no need for , since its already a vector - no two dimensions
testing_y = y[test]


#LDA
set.seed(1)
library(MASS) #Load Mass to enable LDA and QDA 
lda_model = lda(type~.,
                data = training_data)
summary(lda_model)

pred_lda = predict(lda_model, testing_data)
pred_lda #this provided the category already with the predict model
names(pred_lda)

pred_lda_y = pred_lda$class #selecting just class from data frame

#misclassification error
mean(pred_lda_y != testing_y)

### fit tree model for training data

library(ISLR)
library(tree)

set.seed(1)
tree_model = tree(type~., data = training_data) #we took our -Sales because it would have correlated with High (Based on Sales >8)
plot(tree_model)
text(tree_model, pretty = 0) #enables bad / medium text on top of tree
#R presents condition = go to the left, opposite of that is to the right
#Important variables are on the splits

#Display the Probabilities
tree_model

### check accuracy of the model
predicted_y = predict(tree_model, testing_data, type = "class")
mean(predicted_y != testing_y)

### bagging

library(randomForest)
library(MASS)

head(fgl)

attach(fgl)

### Bagging
set.seed(1)
bag_model = randomForest(type~., 
                          data = fgl,
                          mtry = 9, #specific number of predictors (all predictors)
                          importance = T) #gives you variable which is most important

bag_model

### Random Forest
set.seed(1)
rf_model = randomForest(type~., 
                         data = fgl,
                         mtry = 3, #specific number of predictors (sqrt of predictors)
                         importance = T) #gives you variable which is most important

rf_model
