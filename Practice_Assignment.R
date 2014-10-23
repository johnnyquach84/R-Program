dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")

andy <- read.csv("diet_data/Andy.csv")
head(andy)

length(andy$Day) #identify the # of rows for the day column

dim(andy) #identify rows and columns for dataset andy

str(andy)

summary(andy)

names(andy)

andy[1, "Weight"]  #Starting weight for Andy first day/row

andy[30, "Weight"] #Final weight for Andy last day / row (30)

andy[which(andy$Day == 30), "Weight"] #Subset of Weight column where day is equal to 30

andy[which(andy[,"Day"] == 30), "Weight"] #Subset of Weight column where day is equal to 30

subset(andy$Weight, andy$Day==30) #Subset of Weight column where day is equal to 30

andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]

andy_loss <- andy_start - andy_end
andy_loss

files <- list.files("diet_data")

files

#subset the files
files[1]
files[2]
files[3]

head(read.csv(files[3])) #will give error because the path file isn't appended

files_full <- list.files("diet_data", full.names=TRUE)  #append the path to the file name to load correctly
files_full     

head(read.csv(files_full[3]))

#to create one big data frame with everybody's data in it
#use rbind and loop

andy_david <- rbind(andy, read.csv(files_full[2]))

andy_david
