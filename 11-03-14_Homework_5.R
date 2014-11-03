library(ISLR)

?Carseats



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