library(ISLR)


?Hitters

#19 predictors to estimate the salary
#use the subset selection method

#cp, bic, R^2 adj

attach(Hitters)

#check for missing salary values
sum(is.na(Salary))

#count 0 and 1 together, Total 1 = how many NA you have.
#59 - Missing Salary, must remove
#supervise - unsupervise (no Y)

HittersUpdate = na.omit(Hitters)

attach(HittersUpdate)
dim(HittersUpdate)

#Observations with missing values are deleted
#use subset selection to decide what vars should be in our model

library(leaps)
#use leaps package to run subset selection

model = regsubsets(Salary~., data = HittersUpdate)

summary(model)

#the * in the output refers that the variable is included in the model
#notice that the regsubsets function only gives you the first 8 models with 8 vars
#We can change regsubsets to increase beyond 8 models

model1 = regsubsets(Salary~., data = HittersUpdate, nvmax = 19)

model_summary = summary(model1)

#Running regression analysis on each model
#giving us a MSE, each correlated variables will increase the MSE
#model not taking into consideration here
#1st Step - Conduct correlation matrices, understand what is in the dataset first
#IE. Correlation Matrix, etc.

names(model_summary)
#Give us the names of the important variables in the model

model_summary$adjr2
#give us adjr2 for all model

max(model_summary$adjr2)
#give us highest adjr2 in models

#plot in order to find which model is best based on adjusted r2

plot(model_summary$obj,model_summary$adjr2
     xlab = "Objects",
     ylab = "AdjR2")

?plot

#more than one plot on the same background

par(mfrow= c(1,2)) #this is 1 by 2


plot(1:19, model_summary$adjr2,
     xlab = "Variables",
     ylab = "AdjR2",
     type = "o")

index = which.max(model_summary$adjr2)
#11th variable

points(index,
       model_summary$adjr2[index],
       col = "red",
       cex = 2,
       pch = 20)

#changes this point to color red and added one more bigger point and pch = fill the dot

plot(1:19, 
     model_summary$cp,
     xlab = "Variables",
     ylab = "cp",
     type = "o")

mincp = which.min(model_summary$cp)

points(mincp,
       model_summary$cp[mincp],
       col = "red",
       cex = 2,
       pch = 4)

abline(v=mincp, col = "blue")

#abline = creates a vertical line through the plot
