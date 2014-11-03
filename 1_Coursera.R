install.packages("swirl")
library(swirl)
install_from_swirl("R Programming")
swirl()
Johnny

### QUIZ 1 ###
x <- c(1,3, 5) 
y <- c(3, 2, 10)
rbind(x,y)

x <- list(2, "a", "b", TRUE)
x[[2]]

x<- 1:4
y<- 2:3
x+y

x <- c(17, 14, 4, 5, 13, 12, 10)
x[x>10] <- 4
x

read.csv(file = "hw1_data.csv")
hw1 <- read.csv(file = "hw1_data.csv")
names(hw1)
head(hw1)

hw1[152:153,]

dim(hw1)

hw1[47,] #give me row 47
sum(is.na(hw1[,1])) #give me total number of NA for column 1

(is.na(hw1[,1]))
newdata <- na.omit(hw1)
mean(newdata[,1])

head(hw1)

newnewdata <- hw1[which(hw1$Ozone > 31 & hw1$Temp > 90),]  #select subset data only with ozone >31 and temp>90
newnewdata
mean(newnewdata[,2])

temp <- hw1[which(hw1$Month == 6),]
meantemp <- mean(temp[,4])
meantemp

MaxOz <- hw1[which(hw1$Month == 5),]
max(MaxOzNoNA[,1])
MaxOzNoNA<- na.omit(MaxOz)

x <- 4L
class(x)

x <- c(4, TRUE)
class(x)
