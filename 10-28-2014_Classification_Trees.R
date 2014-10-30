library(ISLR)
library(tree)

attach(Carseats)

### data manipulation
?Carseats # the dataset is to predict the Sales of child car seats in 400 locations
head(Carseats) # we can see that Sales is numerical variable, so we might need to create a categorical variable for the sake of classification

range(Sales) #Sales range from 0 to 16
High = ifelse(Sales >=8, "Yes", "No") # create a categorical variables bases on Sales
Carseats = data.frame(Carseats, High) # appends High to Carseat dataset, and now our dataset is ready!

### split data into training and testing 
set.seed(2)
train = sample(1:nrow(Carseats), nrow(Carseats)/2)
test = -train
training_data = Carseats[train,]
testing_data = Carseats[test, ]
testing_High = High[test]

### fit tree model for training data
tree_model = tree(High~.-Sales, data = training_data) #we took our -Sales because it would have correlated with High (Based on Sales >8)
plot(tree_model)
text(tree_model, pretty = 0) #enables bad / medium text on top of tree
    #R presents condition = go to the left, opposite of that is to the right
    #Important variables are on the splits

#Display the Probabilities
tree_model

### check accuracy of the model
predicted_y = predict(tree_model, testing_data, type = "class")
mean(predicted_y != testing_High)
    #0.285 error rate

#Perform cross validation to find the size of the tree
set.seed(1) #CV involves randomness
cv_tree = cv.tree(tree_model, FUN= prune.misclass)
names(cv_tree)
    #dev = error rate
    #size = best size = min. Dev

cv_tree$size
cv_tree$dev

    #Tree Size of 9 or 7 is the best accuracy
    #Lowest Dev = 61

### prune the tree for 7
set.seed(1)
pruned_model = prune.misclass(tree_model, best = 7)
plot(pruned_model)
text(pruned_model, pretty = 0)
    #Pruned tree = removed overfitting of the model

### check accuracy of pruned tree
predicted_y = predict(pruned_model, testing_data, type = "class")
mean(predicted_y != testing_High)
    #0.26 Error Rate


### prune the tree for 9
set.seed(1)
pruned_model = prune.misclass(tree_model, best = 9)
plot(pruned_model)
text(pruned_model, pretty = 0)
    #Pruned tree = removed overfitting of the model

### check accuracy of pruned tree
predicted_y = predict(pruned_model, testing_data, type = "class")
mean(predicted_y != testing_High)
    #0.23 Error Rate
    
### 9 is the better model because of the lower error rate ###
