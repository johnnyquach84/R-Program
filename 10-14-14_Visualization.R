#visualization techniques

library(ggplot2)
library(ggmap)

qmap("University of Southern California",
     zoom = 14)

qmap("White house",
     zoom = 14)

qmap("White house",
     zoom = 14, 
     maptype = "satellite")

qmap("White house",
     zoom = 14, 
     maptype = "roadmap")

qmap("White house",
     zoom = 14, 
     maptype = "hybrid")

qmap("White house",
     zoom = 14, 
     maptype = "toner")

#Visualize crime data 

?crime

summary(crime)

attach(crime)
qmap("Houston")
summary(offense)

violent_crimes = crime[offense %in% c("murder","rape","aggravated assault","theft"),]

#%in% will check for only these things in the vector c()

#altnerative way

violent_crimes = subset(crime, offense == "murder" 
                                  | offense == "rape"
                                  | offense == "aggravated assault")
#| = used as or

HoustonMap <- qmap("Houston", zoom = 12)

# focus on downtown Houston

gglocator(2) #interactive formula, select plots on the map
#        lon      lat
#1 -95.47315 29.83618
#2 -95.22066 29.65119

violent_crimes = subset(violent_crimes,
                        lon >= -95.47315 &
                        lon <= -95.23066 &
                        lat >= 29.65119  &
                        lat <= 29.83618)

HoustonMap +
              geom_point(aes(x = lon, y = lat,
                            colour = offense,
                            size = offense
                            ),
                        data = violent_crimes)


HoustonMap +
  stat_bin2d(aes(x = lon, y = lat,
                 colour = offense,
                 fill = offense,
                     alpha = 0.2),
             data = violent_crimes)

geocode("4814 Austin St.") #address to get the lon and lat

#read file, store in vector and geocode specific vector





