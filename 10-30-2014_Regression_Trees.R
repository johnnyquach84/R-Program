library(MASS)
library(tree)
attach(Boston)


### split data into training and testing 
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
test = - train

training_data = Boston[train,]
testing_data = Boston[test,]
testing_medv = medv[test]

### fit tree model for training data
tree_model = tree(medv~., training_data)
plot(tree_model)
text(tree_model)
    #most important is LSTAT (listed first)

### check accuracy of the model
predicted_y = predict(tree_model, testing_data)
mean((predicted_y - testing_medv)^2)
    #MSE = 25.04559

### prune the tree
cv_tree = cv.tree(tree_model)

cv_tree$dev
min_index = which.min(cv_tree$dev)
min_index
    #first one is the lowest k

tree_size = cv_tree$size[min_index]
tree_size
    #size is 8, best tree size
    #original tree is 8, no need to prune
    #the pruned tree is the same as the original tree

### check accuracy of pruned tree

### Pruning just to show code
pruned_tree = prune.tree(tree_model, best = 8)
plot(pruned_tree)
text(pruned_tree)  #overlay text on the plot

predicted_y = predict(pruned_tree, testing_data)
mean((predicted_y - testing_medv)^2)
    #MSE = 25.04559

###Bagging Advantages, A lot of training data and reduces variances
###Bagging for Regression Trees
    #will reduce variance and keep the bias low
    #conducting hundreds of test models and then averaging

###Out-of-Bag Error Estimation
    #Random Samples of selection of subset
    #Trees can be a bit different because random samples will produce
    #different variables that can be the highest significant variable
  

