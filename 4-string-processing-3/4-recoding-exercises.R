library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(ggplot2)

install.packages("htmlwidgets")
install.packages("pdftools")

# Exercises for recoding:
# 
# Using the gapminder data, you want to recode countries longer 
# than 12 letters in the region “Middle Africa” to their abbreviations 
# in a new column, “country_short”. Which code would accomplish this?

# Not correct
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(recode(country, 
                "Central African Republic" = "CAR", 
                "Congo, Dem. Rep." = "DRC",
                "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
ggplot(dat, aes(year, life_expectancy, color = country)) + geom_line()

# Not correct
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                c("Central African Republic", "Congo, Dem. Rep.", "Equatorial Guinea"),
                                c("CAR", "DRC", "Eq. Guinea")))
head(dat)
ggplot(dat, aes(year, life_expectancy, color = country)) + geom_line()

# Not correct
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country = recode(country, 
                          "Central African Republic" = "CAR", 
                          "Congo, Dem. Rep." = "DRC",
                          "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
ggplot(dat, aes(year, life_expectancy, color = country)) + geom_line()

# This one is correct: properly recodes each country in a new column 
# “country_short”.
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
ggplot(dat, aes(year, life_expectancy, color = country)) + geom_line()
