#load necessary libraries
library(tidyverse)
library(dplyr)
library(readr)
library(tidyr)

#load original dataset to be cleaned
refine_original <- read_excel("~/R/refine.xlsx")
View(refine_original)

#sort alphabetically by company name
refine_original <- refine_original %>% 
  arrange(company)

#change row name data manually by specific row (this needs to be completed algorithmically versus manually)
refine_original[8:16,1] <- "philips"
refine_original[1:7,1] <- "akzo"
refine_original[21:25,1] <- "van houten"
refine_original[17:20,1] <- "unilever"

#separate "Product code / number" column into product_code and product number and remove it afterwards
refine_original <- refine_original %>% 
  separate('Product code / number', c("product_code","product_number"),sep = "-", remove=TRUE)

#add logical operator for what type of device each row contains
refine_original <- refine_original %>% 
  mutate(Smartphone = product_code == 'p') %>% 
  mutate(TV = product_code == 'v') %>% 
  mutate(Laptop = product_code == 'x') %>% 
  mutate(Tablet = product_code == 'q')

#add full address for geocoding separated by commas (but not commas with spaces)
refine_original <- refine_original %>% 
  mutate(full_address = paste(address, city, country, sep = ","))

#create dummy variables
# 1. company
refine_original <- refine_original %>%
  mutate(company_akzo = as.numeric(company == 'akzo')) %>% 
  mutate(company_philips = as.numeric(company == 'philips')) %>% 
  mutate(company_unilever = as.numeric(company == 'unilever')) %>% 
  mutate(company_van_houten = as.numeric(company == 'van houten'))
# 2. product
refine_original <- refine_original %>%
  mutate(product_smartphone = as.numeric(Smartphone == 'TRUE')) %>% 
  mutate(product_tv = as.numeric(TV == 'TRUE')) %>% 
  mutate(product_laptop = as.numeric(Laptop == 'TRUE')) %>% 
  mutate(product_tablet = as.numeric(Tablet == 'TRUE'))

write.csv(refine_original,"~/R/refine_clean.csv" )