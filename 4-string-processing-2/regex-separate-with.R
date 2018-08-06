library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

# Now we want to extract and save the feet and
# number value so we can conver to inches.

s <- c("5'10", "6'1")
tab <- data.frame(x = s)

# We can use separate to separate out the feed
# and inches parts

tab %>% separate(x, c("feet", "inches"), sep = "'")
# feet inches
# 1 5'10   <NA>
# 2  6'1   <NA>

# We can use the extract function from tidyr package:

tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
# feet inches
# 1 5'10   <NA>
# 2  6'1   <NA>

# We need extract because of situations where separate
# fails. Here is an example:

s<- c("5'10", "6'1\"","5'8inches")
tab <- data.frame(x = s)
tab %>% separate(x, c("feet", "inches"), sep = "'", fill = "right")
# feet  inches
# 1    5      10
# 2    6      1"
# 3    5 8inches

# But we can use extract - the regex is a bit more complicated
# because we have to permit the single quote with spaces
# in feet while wanting the double quotes included in the value

tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
# feet  inches
# 1    5      10
# 2    6      1
# 3    5      8

# We are now ready to put everything we've done so far together and 
# wrangle our reported heights data as we try to recover as many heights 
# as possible. The code is complex but we will break it down into parts.

# We start by cleaning up the height column so that the heights are closer 
# to a feet'inches format. We added an original heights column so we can 
# compare before and after.

# Let's start by writing a function that cleans up strings so that all the 
# feet and inches formats use the same x'y format when appropriate.

pattern <- "^([4-7])\\s*'\\s*(\\d+\\.?\\d*)$"

smallest <- 50
tallest <- 84
new_heights <- reported_heights %>% 
  mutate(original = height, 
         height = words_to_numbers(height) %>% convert_format()) %>%
  extract(height, c("feet", "inches"), regex = pattern, remove = FALSE) %>% 
  mutate_at(c("height", "feet", "inches"), as.numeric) %>%
  mutate(guess = 12*feet + inches) %>%
  mutate(height = case_when(
    !is.na(height) & between(height, smallest, tallest) ~ height, #inches 
    !is.na(height) & between(height/2.54, smallest, tallest) ~ height/2.54, #centimeters
    !is.na(height) & between(height*100/2.54, smallest, tallest) ~ height*100/2.54, #meters
    !is.na(guess) & inches < 12 & between(guess, smallest, tallest) ~ guess, #feet'inches
    TRUE ~ as.numeric(NA))) %>%
  select(-guess)

# We can check all the entries we converted using the following code:

new_heights %>%
  filter(not_inches(original)) %>%
  select(original, height) %>% 
  arrange(height) %>%
  View()