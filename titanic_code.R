
#load necessary libraries
library(tidyverse)
library(dplyr)
library(readr)
library(tidyr)

#load original dataset to be cleaned
titanic_original <- read_excel("~/R/titanic_original.xlsx")
View(titanic_original)

#sort alphabetically by embarked
titanic_original <- titanic_original %>% 
  arrange(embarked)

#replace embarked NAs with S
titanic_original$embarked[is.na(titanic_original$embarked)]<-'S'

#replace NA ages with mean age
titanic_original$age[is.na(titanic_original$age)]<-mean(titanic_original$age, na.rm = TRUE)

#replace boat NA with NA
titanic_original$boat[is.na(titanic_original$boat)]<-'NA'

#has cabin number
titanic_original<- titanic_original %>%
  mutate(has_cabin_number = as.numeric(cabin != 'na'))
  titanic_original$has_cabin_number[is.na(titanic_original$has_cabin_number)]<-0
  
  
  write.csv(titanic_original,"~/R/titanic_clean.csv" )