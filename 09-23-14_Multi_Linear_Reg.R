
library(ILSR)

?Carseats

# to check how to interpret categorical variables
# Variables in Multple Linear Regression (MLR) models

# We are not going to split the data into training / testing
# For analysis, we will have to split

# must check for linearity
# ~. = All Variables

model = lm(Sales ~., data = Carseats)
summary(model)

# Estimates = positive or negative relationship
# Look at how R deals with categorical variables
# use the contrasts() function to see dummy variables


contrasts(Carseats$ShelveLoc)
#> contrasts(Carseats$ShelveLoc)
#Good Medium
#Bad       0      0
#Good      1      0
#Medium    0      1

# 0 or 1 is just a trigger to say yes or no

#knn for clustering = majority count
#knn for Linear Regression = takes the average

#probability of 1 P(Y=1), estimating Bo & B1

#Pr default = 1 = yes
#below is to repeat code through function capabilities


cubic <- function(x){  
  
  a = x^3
  return(a)

}

num = cubic(4)

num #num is now corresponding to 64

magic <- function(x){
  
    a=1:x
    return(a)
}

magic(7)





