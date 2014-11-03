### Chapter 03 - Linear Regression ###

# X is used to explain the variation in Y, once you explain 100% of variation in Y
# you find the perfect cause of Y

# Y = Actual relationship
# Y^ = Y-Hat = used for prediction

# Bo = Beta Zero = Y Intercept  -- Straight line cuts the Y Axis
# Bj = Beta J   
  # Bj: If Positive then X has a positive relationship with Y

# Episolon = Errors 
  # Distance from Dot to the plane


# R^2 = Explains portion of the variation between 0 and 1
  # Closer to 1 = It explains the variation better

# If any Bj = 0, then no relations

# T - Test
# Anova Test

#Is Xj an important variable?
  #Run a T-Test
    #1. Setup a null hypothesis [Ho: Bj=0]
    #2. Setup an Alternative Hypo [Ha: Bj=/0]
  #We are trying to reject the null hypothesis - We want Higher T-Value and Small P-Value
    #If P value is less than .05, reject the null
    #This means the Ha is correct
  #Standard Error = Std.Dev
    #Small T => Larger P => Higher Std.Error.

  #Example
    #Sales^ = Coefficient (constant) + coefficient(TV) 
    #Presence of other variables will have interactions which changes the p-value

#Is the whole regression explaining anything?
  #Run an Anova Model
    #1. Setup null [Ho: All slopes = 0]
    #2. Setup Alt  [Ha: At least one slope =/ 0]
    #We care about the F Ratio and corresponding p-value
      #We want the F to be high and P-value to be low



rm(list= ls()) ## Clearing Environments
rm() = ## Clear specific vars in Environment
  

### Simple Linear Regression

# Load the MASS package in R, so we can get access to the boston dataset


library(MASS)
attach(Boston)  
  
## Learn about Boston
?Boston

data = Boston

# We will use lstat as our explanatory variable and medv as our response variable

# Split the data

train = 1:400
test = -train

# No need to split Y and K because this isn't KNN

variables = which(names(Boston) ==c("lstat","medv"))  ## identify which col has these name
training_data = Boston[train, variables]  ## training data boston only capture two variable
testing_data = Boston[test, variables] ## testing data, only two variables

# Use the training data to fit a Linear Model

#1. Check for Linearity
  plot(lstat,medv) #visual verification of linearity
    #1. The relationship deviates a little bit from linearity but let's assume it is linear
      #a. use log to transform data into a bit more linearity
  
  plot(log(lstat),medv)
  
    #2. We can now log our data so we don't have to write log
  
  training_data = log(Boston[train, variables])
  attach(training_data)
  plot(lstat,medv)

#2. Fit the linear moedel using lm() function

  lm(medv~lstat, data = training_data)
    #Results
    #Coefficients:
      #(Intercept)        lstat  
      #4.2678             -0.5079  
  
  model_fit = lm(medv~lstat, data = training_data) #Output saved into a variable
  
  model_fit
  
    #More detailed Output
  summary(model_fit)
    #F-Statstics will be provided and the P-Value, this model is significant
    #Linear data will increase the R^ #

#3. Plot the regression line

plot(lstat,medv)

?abline #Adds a straight line through the plot

abline(model_fit) #Must provide A & B, model_fit already identified as a variable w/ A&B

plot(lstat, medv,
    xlab = "Percentage of Household with Low Income",
    ylab = "Median House Value",
    col = "blue",
    pch = 20) #pch = changes the icon on plot
abline(model_fit, col = "red", lwd = 2) #col = red and lwd = thickness of line

  #PCH field

plot(1:25, 1:25, pch = 1:25)


