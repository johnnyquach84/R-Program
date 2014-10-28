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

day_25 <- andy_david[which(andy_david$Day == 25),]

day_25

for (i in 1:5) {print(i)}

for (i in 1:5) {
  dat <- rbind(dat, read.csv(files_full[i]))
}

# can't rbind something into a file that doesn't exist yet. 
# combined all five files into 1 w/ this loop
dat <- data.frame()
for (i in 1:5) {
  dat <- rbind(dat, read.csv(files_full[i]))
}

str(dat)
?str

median(dat$Weight)
# will give NA because row 77 is missing data 

median(dat$Weight, na.rm=TRUE) #strips NA

dat_30 <- dat[which(dat[,"Day"] == 30),]
dat_30

median(dat_30$Weight)

weightmedian <- function(directory, day) {# content of the function}
  
weightmedian <- function(directory, day) {
  files_list <- list.files(directory, full.names = TRUE) #creates a list of files
  dat <- data.frame()                                    #creates an empty data frame
  for (i in 1:5) {                                       #Loops through the files, rbinding them together  
      dat <- rbind(dat, read.csv(files_list[i]))
  }
  dat_subset <- dat[which(dat[,"Day"] == day),]          #subsets the rows that match the day  
  median(dat_subset[, "Weight"], na.rm=TRUE) #identifies the median weight While stripping NA
}
  
weightmedian(directory = "diet_data", day = 20)

weightmedian("diet_data", 4)

