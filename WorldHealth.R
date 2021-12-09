#Step 1   
## reading the world health data
## load the required packages

library(dplyr)
library(tidyr)
install.packages("tidyverse")

health <- read.csv("Health.csv", header = TRUE,sep = ",",quote = "\"",dec = ".", fill = TRUE, comment.char = " ", skip = 4 )
meta_health <- read.csv("Metadata.csv", header = TRUE, sep = ",",quote = "\"",dec = ".", comment.char = "" )
#Step 2
##remove the empty columns from health
health_subset<-(select(health,-c(5:44,64,65,66)))
              

##remove extra characters from column names from health
##load stringr() package
library(stringr)

##remove na values from health and rename to Healthclean

Healthclean<- na.omit(health_subset)

##remove the "X" before the years e.g "X2000" to "2000" from Healthclean
names(Healthclean)<-gsub("X","",colnames(Healthclean))

View(Healthclean)


##clean the meta_health data set
##check to see if NA's exist


is.na(meta_health)

##remove column X(it contains NA's)
metahealth_sub <- select(meta_health,-6)

View(metahealth_sub)

##introduce NA's to view the empty strings
metahealth_sub[metahealth_sub==""]<- NA

##omit the empty strings
metahealthclean <- na.omit(metahealth_sub)

View(metahealthclean)


##make sure that both country codes are the same
names(metahealthclean)<- gsub("ï..Country.Code","Country.Code",colnames(metahealthclean))
View(metahealthclean)



##merge the two data frames

Health_all <- merge(Healthclean,metahealthclean)

##format all numeric values to 4 decimal places amd view your results.

Health_comp<-Health_all %>% mutate(across(is.numeric, round, digits=4))
View(Health_comp)


##save the data set as a csv file
write.csv(Health_comp, "Health_comp.csv", row.names = FALSE)




