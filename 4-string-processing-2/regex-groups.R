library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

# Groups are a powerful aspect of regex that permits the extraction of values.
# Groups are defined using parentheses.
# They don't affect the pattern matching per se.
# Instead, it permits tools to identify specific parts of the pattern
# so we can extract them.
# So, for example, we want to change height
# like 5.6 to five feet, six inches.
# To avoid changing patterns such as 70.2, we'll
# require that the first digit be between four and seven--
#   we can do that using the range operation--
#   and that the second be none or more digits.
# We can do that using backslash, backslash d star.
# Let's start by defining a simple pattern that matches this.

pattern_without_groups <- "^[4-7],\\d*$"

# We want to extract the digits so that we can then form
# the new version using a single quote.
# These are two groups, so we encapsulate them with parentheses like this.

pattern_with_groups <- "^([4-7]),(\\d*)$"

yes <- c("5,9", "5,11", "6,", "6,1")
no <- c("5'9", ",", "2,8", "6.1.1")
s <- c(yes, no)
str_detect(s, pattern_without_groups)
str_detect(s, pattern_with_groups)

# Once we define groups, we can use a function str_match
# to extract the values these groups define, like this.
# Look what happens if we write this code.

str_match(s, pattern_with_groups)

#      [,1]   [,2] [,3]
# [1,] "5,9"  "5"  "9" 
# [2,] "5,11" "5"  "11"
# [3,] "6,"   "6"  ""  
# [4,] "6,1"  "6"  "1" 
# [5,] NA     NA   NA  
# [6,] NA     NA   NA  
# [7,] NA     NA   NA  
# [8,] NA     NA   NA 

# Note that the second and third columns contain feet and inches respectively.
# The first is the original pattern that was matched.
# If no match occurred, we see an N/A.
# Now we can understand the difference between the function str_extract
# and str_match.

# str_extract extracts only strings that match a pattern,
# not the values defined by the groups.

# Here's what happens with string extract.

str_extract(s, pattern_with_groups)

# [1] "5,9"  "5,11" "6,"   "6,1"  NA     NA     NA     NA 

# Another powerful aspect of groups is that you
# can refer to the extracted value in regex when searching and replacing.
# The regex special character for the i-th group is backslash, backslash, i.
# So backslash, backslash, 1 is the value extracted from the first group,
# and backslash, backslash, 2 is the value from the second group, and so on.
# So as a simple example, note that the following code
# will replace a comma by a period, but only if it is between two digits.

str_replace(s, pattern_with_groups, "\\1'\\2")

# [1] "5'9"   "5'11"  "6'"    "6'1"   "5'9"   ","     "2,8"   "6.1.1"

# Now we're ready to define a pattern that helps us convert all the x.y, x,y,
# and x y's to our preferred format.

# We need to adapt pattern underscore with groups to be a bit more flexible
# and capture all these cases. The pattern now looks like this.

pattern_with_groups <- "^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$"

# The caret means start of the string.
# Then four to seven means one digit between four and seven--four, five, six, or seven.
# Then the backslash, backslash, s, star means none or more white spaces.
# The next pattern means the fifth symbol is either comma, or dot, or at least one space.
# Then we have none or more white spaces again.
# Then we have none or more digits, and then the end of the string.

str_subset(problems, pattern_with_groups) %>%
  str_replace(pattern_with_groups, "\\1'\\2") %>% head

# EXERCISES

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")

# In the above, You forgot to check for any spaces in your regex pattern. 
# While the first two entries of “problems” have commas and periods correctly 
# replaced, the last three entries are not identified as part of the pattern 
# and are not replaced.

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")

# The new regex pattern now checks for one character, 
# either a comma, period or space, between the first digit 
# and the last one or two digits, and replaces it with an 
# apostrophe (‘). However, because your last two problem 
# strings have additional space between the digits, they are not corrected.