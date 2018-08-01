library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(purrr)
install.packages("htmlwidgets")
install.packages("purrr")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

schedule <- read_csv("schedule.csv")
schedule

str_split(schedule$staff, ",|and")
str_split(schedule$staff, ", | and ")
str_split(staff$Staff, ",\\s|\\sand\\s")
str_split(staff$Staff, "\\s?(,|and)\\s?")

# This code turns the csv into a tidy table:

tidy <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ")) %>% 
  unnest()
tidy

# A tibble: 6 x 2
# day     staff
# <chr>   <chr>
#   1 Monday  Mandy
# 2 Monday  Chris
# 3 Monday  Laura
# 4 Tuesday Steve
# 5 Tuesday Ruth 
# 6 Tuesday Frank

tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = “,”) %>% 
  gather(key = s, value = staff, s1:s3)

tidy <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ", simplify = TRUE)) %>% 
  unnest()
tidy