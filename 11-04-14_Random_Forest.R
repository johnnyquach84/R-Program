install "randomForest" Package

#Random Forest- Sample at each level of separation - provide chance all variables to be a significant predictor

### bagging and random forests

library(randomForest)
library(MASS)

    #we will work on Boston DataSet

attach(Boston)

### Bagging
    #constitutes BootStrapping
    #Some observation was not part of sample
    #RandomForest will use it as a testing data ^
    #All variables are used in Bagging

set.seed(1)
bag_model <- randomForest(medv~., 
                          data = Boston,
                          mtry = 13, #specific number of predictors (all P = 13 currently in Boston)
                          importance = T) #gives you variable which is most important
dim(Boston)

bag_model

### RandomForest
    #Enhanced version of bagging so model should be better

set.seed(1)
rf_model <- randomForest(medv~., 
                         data = Boston,
                         mtry = 4, #specific number of predictors (sqrt of predictors)
                         importance = T) #gives you variable which is most important

rf_model
    #most cases RF model will be the best model

### Check for important variables

rf_model$importance

    #%IncMSE IncNodePurity
    #crim     8.7005768     2486.0422
    #zn       0.4869422      284.0270
    #indus    6.6984020     2838.7832
    #chas     0.5545707      231.3077
    #nox      8.9210669     2707.7264
    #rm      34.4362498    12416.3171
    #age      3.8182257     1076.3452
    #dis      7.1312398     2540.4924
    #rad      1.7309356      368.4620
    #tax      3.6071522     1309.7731
    #ptratio  6.9703808     2619.5196
    #black    1.2905827      762.2800
    #lstat   62.5045507    12283.5197
  
    ##If you take out lstat, MSE increases by 62.5%.  
    ##LSTAT and RM are the most important

barplot(sort(rf_model$importance[,2],
             decreasing = T))
