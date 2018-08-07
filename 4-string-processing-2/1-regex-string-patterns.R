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
# 
# After applying these steps, we will then check again
# to see what entries were not fixed, and see if we can tweak our approach
# to be more comprehensive. This is very common in data science.
# There's a lot of interactive approaches that are applied.

# A regular expression, a regex, is a way to describe
# specific patterns of a character of text that
# can be used to determine if a given string matches the pattern.
# A set of rules have been defined to do this efficiently and precisely,

# Technically, any string is a regex. Perhaps the simplest example is a single 
# character. So the comma that we used before--  here is the code--

pattern <- ","

str_detect(reported_heights$height, pattern)

# ...is a simple example of searching with a regex. We noted that an entry 
# included centimeters, cm. This is also a simple example of a regex.
# We can show all the entries that use "cm" like this. We use the function str_subset.

str_subset(reported_heights$height, "cm")

# Let's ask which of the following strings satisfy your pattern.
# We're going to define "yes" as the ones that do,
# and "no" as the ones that don't, and then
# create one vector of strings, called s, including both.
# So we're asking which of the strings include the pattern "cm" or the pattern
# "inches." We could call str_detect twice, like this but we don't need to do this. 

yes <- c("180 cm", "70 inches")
no <- c("180", "70''")
s <- c(yes, no)

# The main feature that distinguishes the regex language from plain strings
# is that we can use special characters.
# These are characters that have a meaning.
# We start by introducing this character, which means "or."
# So if you want to know if either "cm" or "inches" appears in the, string
# we can use the regex bar inches, like this, and obtain the correct answer.

str_detect(s, "cm|inches")

# Another special character that will be useful for identifying feet and inche values
# is the backslash d, # which means any digit, 0, 1, 2, 3, up to 9.
# The backslash is used to distinguish it from the character "d."

# In R, we have to escape the backslash, so we actually
# have to use two backslashes, and then a d to represent digits.

yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ",", "five", "six")

s <- c(yes, no)
pattern <- "\\d"
str_view(s, pattern)
str_detect(s, pattern)

# [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE

# We take this opportunity to introduce the very useful str_view function.
# This is a helpful function for troubleshooting, as it shows us the first 
# match for each string. So if we type str_view (s, and then the pattern,
# it shows us the first time a digit was found.

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
