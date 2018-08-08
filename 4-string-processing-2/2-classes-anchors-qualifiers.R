library(tidyverse)
library(dslabs)
install.packages("htmlwidgets")

# Character classes are used to define a series of characters
# that can be matched. We define character classes with the square brackets ([ ]).
# So for example, if we want the parent to match only if we have a 5 or a 6,
# we can use the regex, square brackets, 5, 6.

str_view(s, "[56]")
#
# 70
# 5 ft
# 4'11
# .
# Six feet

pattern <- "^\\d$"
yes <- c("1", "5", "9")
no <- c("12", "123", "1", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)
#
# 1     (highlighted)
# 5     (highlighted)
# 9     (highlighted)
# 12
# 123
# 1     (highlighted)
# a4
# b

# A common way to define a character class is with ranges.
# So for example, if we use the brackets [0-9] and then 0 through 9,
# this is equivalent to using the backlash d.
# It's all the digits.
# So the pattern square brackets 4 to 7 will match the numbers 4, 5, 6, and 7.
# We can see it in this example.

yes <- as.character(4:7)
no <- as.character(1:3)
s <- c(yes, no)
str_detect(s, "[4-7]")

# However, it is important to know that in regex, everything is a character.
# There are no numbers. So 4 is the character 4, not the
# number 4. Note, for example, that if we type 1 through
# 20 [1-20], this does not mean 1, 2, 3, 4, 5, up to 20. It
# means the character 1 to 2 and 0.

# [a-z] 
# [A-Z]

# Anchors allow us to define strings that MUST start or
# end at specific places. The two most common are the caret
# and the dollar sign. So:

# ^\\d$

# is read as the start of a string followed by one digit
# followed by the end of the string. This will only detect
# strings of one digit:

pattern <- "^\\d$"
s <- c("1", "52", "977", "6")
str_view(s, pattern)

pattern <- "^\\d$"
s <- c("12", "123",  " 1", "a4", "b")
str_view(s, pattern)

# For the inches part, we can have one or two digits.
# This can be specified in regex with quantifiers.
# This is done by following the pattern by curly brackets
# with the possible number of times the previous entry repeats.
# So the pattern for one or two digits is like this-- backslash, backslash,
# d, and then curly brackets, 1 comma 2.
# So this code will do what we want.

pattern <- "^\\d{1,2}$"
yes <- c("1", "5", "9", "6")
no <- c("12", "123",  " 1", "a4", "b")
str_view(c(yes, no), pattern)

# So now, to look for one feet and inches pattern, we can add the symbol for feet
# and the symbol for inches after the digits.
# With what we have learned, we can now construct
# an example for the pattern x feet and y inches,
# with the x representing feet and the y inches.
# It's going to look like this.

pattern <- "^[4-7]'\\d{1,2}\"$"

# Let's test it out.
# Let's make some strings where it is feets and inches, others
# where we shouldn't get a match.

yes <- c("5'7\"", "5'2\"", "6'3\"", "6'12\"")
no <- c("1,2\"", "6.2\"",  "I am 1'4\"", "3'2\"")

# Now note the difference between str_view() and str_detect()
str_view(c(yes, no), pattern)
str_detect(c(yes, no), pattern)