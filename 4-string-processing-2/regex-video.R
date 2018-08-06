# Video on regex (regular expressions)

library(dslabs)
library(tidyverse)
library(stringr)

install.packages("htmlwidgets")

data("reported_heights")

# We have seen three patterns that define many problematic entries.
# We will convert entries fitting the first two
# patterns into a standardized one.
# We'll then leverage this standardization to extract the feet and inches,
# and convert to inches.
# We will then define a procedure for identifying
# entries that are in centimeters, and convert these to inches.
# # After applying these steps, we will then check again
# to see what entries were not fixed, and see if we can tweak our approach
# to be more comprehensive.
# This is very common in data science.
# There's a lot of interactive approaches that are applied.

# A regular expression, a regex, is a way to describe
# specific patterns of a character of text that
# can be used to determine if a given string matches the pattern.
# A set of rules have been defined to do this efficiently and precisely,

pattern <- ","
str_detect(reported_heights$height, pattern)

str_subset(reported_heights$height, "cm")

yes <- c("180 cm", "70 inches")
no <- c("180", "70''")
s <- c(yes, no)

str_detect(s, "cm|inches")

# Another special character that will be useful for identifying feet and inche values is the backslash d, # which means any digit, 0, 1, 2, 3, up to 9.
# The backslash is used to distinguish it from the character "d."

yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ",", "five", "six")

s <- c(yes, no)
pattern <- "\\d"
str_view(s, pattern)
str_detect(s, pattern)

str_view(s, pattern)
str_view_all(s, pattern)

s <- c("70", "5 ft", "4'11", "", ".", "Six feet")
pattern <- "\\d|ft"
str_view_all(s, pattern)

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]"
str_detect(animals, pattern)

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[A-Z]$"
str_detect(animals, pattern)

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]{4,5}"
str_detect(animals, pattern)

pattern <- "^[4-7]'\\d{1,2}\"$"
problems <-[c(2, 10 , 12, 15)] %>% str_view(pattern)
sum(str_detect(problems, pattern))

str_subset(problems, "inches")

animals <- c("moose", "monkey", "meerkat", "mountain lion")
pattern <- "moo*"
str_detect(animals, pattern)

# This is one more change to test github
