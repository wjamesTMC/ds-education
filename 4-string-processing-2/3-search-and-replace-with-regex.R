library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

#  In a previous video, we defined the object problems
#  containing the strings that do not appear to be in inches.
#  We can see that only these many of them match the pattern we define.
#  To see why this is, we show examples that expose why we don't have more
#  matches.
#
pattern <- "^[4-7]'\\d{1,2}\"$"
sum(str_detect(problems, pattern))
# [1] 14

#  We see that only two of them match. Why is that?
#
#  A first problem we see immediately is that some students wrote out
#  the words feet and inches. We can see the entries that did this with 
#  the function strict subset, ike this. We see several examples.

str_subset(problems, "inches")
# [1] "5 feet and 8.11 inches"  "Five foot eight inches"  "5 feet 7inches"
# [4] "5ft 9 inches"            "5 ft 9 inches"           "5 feet 6 inches"

# We also see that some entries use the single quotes twice to represent
# inches instead of the double quotes.

str_subset(problems, "''")
# [1] "5'9''"   "5'10''"  "5'10''"  "5'3''"   "5'7''"   "5'6''"   "5'7.5''"
# [8] "5'7.5''" "5'10''"  "5'11''"  "5'10''"  "5'5''"  

# First thing we can do to solve this problem
# is to replace the different ways of representing
# inches and feet with a uniform symbol. We'll use a single quote for 
# feet, and for inches, we'll simply not use anything.
# So our pattern will be this then.

pattern <- "^[4-7]'\\d{1,2}$"

# If we do this replacement before the matching, we get many more matches.
# So we're going to use the string replace function to replace feet,
# ft, foot with the feet symbol.
# We will simplify the pattern by no longer using the inches symbol at the end
# so 5'4 will denote 5 feet 4 inches. Now the pattern looks like this:

pattern <- "^[4-7]'\\d{1,2}$"

# Before we run this, we will do some string replacement to replace "feet" and "inches"
# with the feet symbols. We run this and see we get many more matches:

problems %>% str_replace("feet|ft|foot", "'") %>%
  str_replace("inches|in|''|\"", "") %>%
  str_detect(pattern) %>%
  sum
# [1] 48

# Another problem is spaces - we did not get matches where spaces exist
# Spaces can be represented by \s -- So to find patterns like 5, single 
# quote, space, and then another digit, we can change our pattern to the 
# following.

pattern_2 <- "^[4-7]'\\s\\d{1,2}\"$"
str_subset(problems, pattern_2)
# [1] "5' 4\""  "5' 11\"" "5' 7\"" 

# So do we need more than one regex pattern--one for the space and one 
# without the space? No, we don't. We can use quantifiers for this as well.
# So we want a pattern to permit spaces but not to require them.
# Even if there are several spaces like this, we will still want it to 
# match. There is a quantifier exactly for this purpose. In regex, the 
# asterisk character means zero or more instances of the previous character.

# So we can improve the pattern by adding the * after \\s

pattern_2 <- "^[4-7]'\\s*\\d{1,2}\"$"

# Now there are two other similar quantifiers. For none or once, we can 
# use the question mark. And for one or more, we can use the plus sign.

yes <- c("5", "6", "5'10", "5 feet", "4'11")
data.frame(string = c("AB", "A1B", "A11B", "A111B", "A1111B"),
           none_or_more = str_detect(yes, "A1*B"),
           none_or_once = str_detect(yes, "A1?B"),
           once_or_more = str_detect(yes, "A1+B"))

#   string none_or_more none_or_once once_or_more
# 1     AB        FALSE        FALSE        FALSE
# 2    A1B        FALSE        FALSE        FALSE
# 3   A11B        FALSE        FALSE        FALSE
# 4  A111B        FALSE        FALSE        FALSE
# 5 A1111B        FALSE        FALSE        FALSE

# To improve our pattern, we can add the asterisks after the backslash, 
# s in front and after the feet symbol to permit space between the feet
# symbol and the numbers. Now we match and we get a few more entries.

problems <- reported_heights %>% filter(not_inches(height)) %>% .$height
length(problems)

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
problems %>% str_replace("feet|ft|foot", "'") %>%
  str_replace("inches|in|''|\"", "") %>%
  str_detect(pattern) %>%
  sum

# Why not use str_replace_all? It could have unintentional consequences
# If we remove all spaces, we will incorrectly turn x space y into xy,
# which implies that a 6' 1" person would turn into a 61 inch
# person instead of a 73 inch person.

# --------------------------------------------------------------------
# String exercises - the problems set where heights are not in inches
# --------------------------------------------------------------------

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

problems <- reported_heights %>% filter(not_inches(height)) %>% .$height
length(problems)

pattern <- "^[4-7]'\\d{1,2}\"$"

problems[c(2, 10, 11, 12, 15)] %>% str_view(pattern)

str_subset(problems, "inches")
str_subset(problems, "''")

# New pattern
not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

