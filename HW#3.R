
sample (1:10,4  #select 4 random elements in this vector (random sample)
        ,replace = T) #replace allows for repeated numbers

library(ISLR)
attach(Carseats)

dim(Carseats)  #dim identifies variables n counts

# Randomly choose 300 obs for training
set.seed(1)
train = sample(1:nrow(Carseats),300) #sample will create a vector 1 to 400
test = -train
  
training_data = Carseats[train,]
testing_data = Carseats[test,]

head(Carseats)

model = lm(Sales ~ Population + Urban + US, data = training_data)
summary(model)

              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  6.4801110  0.4733139  13.691  < 2e-16 ***
  Population   0.0008788  0.0011221   0.783 0.434133    
UrbanYes    -0.0641297  0.3486497  -0.184 0.854188    
USYes        1.2163926  0.3322397   3.661 0.000297 ***


#1.d

y = testing_data$Sales

y_hat = predict(model,
                testing_data[,-1])

### Computer the Mean Squared Error 

error = y - y_hat
MSE = mean(error^2)
MSE #8.068095
  


#2. R Functions  
cat("New Password", ) #Output Password


RandomPW <- function(x){
D = c(LETTERS,letters,0:9)
paste(D,collapse= "")
E = sample(D, x)

F = paste(E, collapse= "")

paste("Your new password is:", F)
}

RandomPW(6)

?paste
?sample
