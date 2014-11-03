### In this file, we will use a dataset called
## Caravan.  This dataset is in ISLR Library.


## Library to load into RAM
library(ISLR)

## In order to run KNN methods, then you have to install
## "class" package.

library(class)

### Let's explore Caravan
?Caravan

## dim = gives you rows and columns

dim(Caravan)

rm(Caravan) ## remove data to reload

## identify # of observations dim = Vector and Brackets [ = Subsets]
num_of_obs = dim(Caravan)[1]

##5822L = L = long data type, it represents data type

### Let's explore Purchase

purchase = Caravan[,86]
summary(purchase)

### the proportion of people who bought the insurance

384/num_of_obs

### The KNN Function takes many arguments
### 1. Train = Training dataset (without the y variable)
### 2. Test = Testing dataset (without the y variable)
### 3. Training Dataset y Variable
### 4. K = # of neighbors we are interested in
### remember the training vs testing MSE high -> Low

### check for variances of the variable

var1 = var(Caravan[,1])
var1

var2 = var(Caravan[,2])
var2
### Step 1: Standardize the data
### The variances are very different, so let's
### Standardize the variables (scaling the variables)

Standardize_Caravan = scale(Caravan[,-86])  ### don't want to stdarize a categorical value {Yes or No}
var(Standardize_Caravan[,1])
var(Standardize_Caravan[,2])


### Split the data into training and testing

train = 1:4822
train_data = Standardize_Caravan[train,]  ### No Y column because train already standardized
train_purchase = Caravan[train, 86]  ### Set data to rows 4822 based on vecotr train and only col. 86

test = -train  ### Eliminates train data from Caravan
test_data = Standardize_Caravan[test, ]  ### Only Test data without Y
test_purchase = Caravan[test, 86] ### Only test data with Y

### Step 2: Fit the KNN model

predicted_purchase = knn(train_data,
                          test_data,
                          train_purchase, ### CL = Y Column
                          k = 1) ### Yes / No - One Neighbor

### Step 3: Assess the model, and get the error rate
### by comparing the predicted_purchase to test_purchase

mean(predicted_purchase != test_purchase)  ### != not equal logical test  
### mean = will show you the error rate so only .115 shows your accuracy rate


### The error rate is 11.5%, which is low.

### To control randomness, we can use the set.seed()

set.seed(3)
predicted_purchase = knn(train_data,
                         test_data,
                         train_purchase, ### CL = Y Column
                         k = 1) ### Yes / No - One Neighbor


### change K and see what happens to the error rate
### changed k higher -> Error Rate went up


set.seed(3)
predicted_purchase = knn(train_data,
                         test_data,
                         train_purchase, ### CL = Y Column
                         k = 15) ### Yes / No
mean(predicted_purchase != test_purchase)  ### != not equal logical test  


### use a for loop to check what would be the error rate
### for models with k = 1, ...,100
error = NULL
for(i in 1:20){
set.seed(3)
predicted_purchase = knn(train_data,
                         test_data,
                         train_purchase, ### CL = Y Column
                         k = i) ### Yes / No
error[i] = mean(predicted_purchase != test_purchase)  ### != not equal logical test  
}

error


min_error_rate = min(error)
min_error_rate

k = which(error == min_error_rate) ### Two equal will compare variables to each other

k

library(ggplot2)
qplot(1:20, error)




### [] = array / vector putting i into array = extends the dataset outwards.



## K Clustering = KNN
?knn













