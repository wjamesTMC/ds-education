library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(ggplot2)

install.packages("htmlwidgets")
install.packages("pdftools")

# Another common operation
# involving strings is recoding the names of categorical variables.
# For example, if you have a really long name for your levels,
# and you will be displaying them in plots,
# you might want to use shorter versions of the names.
# For example, in a character vector with country names,
# you might want to change United States of America to USA and United Kingdom
# to UK, and so on.

# We can do this using case when.
# But the tidyverse offers options that are specifically designed
# for this task, the recode function.
# Here's an example showing how to rename countries with long names.

library(dslabs)
data("gapminder")

# Suppose we want to show the life expectancy time series for countries in 
# the Caribbean. So here's a code that will make that plot.

gapminder %>%
  filter(region=="Caribbean") %>%
  ggplot(aes(year, life_expectancy, color = country)) + geom_line()

# This is the plot we want, but much of the space
# is wasted to accommodate some of the long country names.
# Here are some of the longer ones.

# For example, Saint Vincent and the Grenadines.
# We have four countries with names longer than 12 characters.
# These names appear once for every year in the Gapminer data set.
# And once we pick nicknames, we need to change them all consistently.
# The recode functions can be used to do this.

gapminder %>%
  filter(region=="Caribbean") %>%
  mutate(country = recode(country,
                          'Antigua and Barbuda' = "Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad")) %>%
  ggplot(aes(year, life_expectancy, color = country)) + geom_line()

# Notice the recode function is changing all these names to a shorter 
# version, and it's going to do it throughout the entire data set,
# as opposed to one by one.
# Once we do this, then we get a better-looking plot.
# Note that there's other similar functions in the tidyverse.
# For example, 
# 
#   recode_factor()
#   fct_recoder()
# 
# These are in the forcats function in the tidyverse package.

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
