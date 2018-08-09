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

# So why do we even need the new function extract?
# The reason is that groups in regex give us much more flexibility.
# For example, if we define an example like this and we only want 
# the numbers, separate fails. Look at what happens.

s<- c("5'10", "6'1\"","5'8inches")
tab <- data.frame(x = s)
tab %>% separate(x, c("feet", "inches"), sep = "'", fill = "right")
# feet  inches
# 1    5      10
# 2    6      1"
# 3    5 8inches

# We need extract because of situations where separate
# fails. We can use extract - the regex is a bit more complicated
# because we have to permit the single quote with spaces
# in feet while wanting the double quotes included in the value

tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
# feet  inches
# 1    5      10
# 2    6      1
# 3    5      8
