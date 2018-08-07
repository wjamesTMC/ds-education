library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

setwd("C:/Users/jamesw/Documents/ds-education-wrangling")

# In previous courses, we used a heights
# data set in the dslabs package.
# The dslabs package also includes the raw data
# from which these heights were obtained.
# You can load it like this.

data("reported_heights")

# These heights were obtained using a web form in which students were asked
# to enter their heights into a form.
# They could enter anything, but the instructions asked for heights
# in inches, the number.
# We compiled over 1,000 submissions, but unfortunately the column vector
# with the reported heights had several non-numeric entries, and as a result
# became a character vector.
# 
# If we try to parse it into a number, we get a warning.
# There's a lot of NAs.

x <- reported_heights$height
head(x)
# [1] "75" "70" "68" "74" "61" "65"

# Although most values appear to be height in inches as requested--
# here are the first five--
# we do end up with many NAs.
# You can see how many using this code.

sum(is.na(as.numeric(x)))

# We can see some of the entries that are not successfully
# converted by using the filter function to keep only the entries that
# resulted in NAs.
# We can write this code.

reported_heights %>%
  mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height)) %>%
  head(n = 10)

# Now, look at the entries that turn out to be non-numeric.
# We immediately see what's happening.
# Some of the students did not report their heights in inches as requested.
# we could discard these and continue, however, many of the entries
# follow patterns that, in principle, we can easily convert to inches.
# For example, in the output we just saw, we
# see various cases that use the following format, with x representing
# feet and y representing inches.
# Each of these cases can be read and converted to inches by a human.
# For example, if you write 5'4" like this, this is 5 times 12 plus 4,
# which is 64 inches.
# So we could fix all the problematic entries by hand.
#
# However, humans are prone to making mistakes.
# Also, because we plan on continuing to collect data going forward,
# it'll be convenient to write code that automatically does this.
# A first step in this type of task is to survey the problematic entries
# and try to define specific patterns followed by a large group of entries.
# The larger these groups, the more entries
# we can fix with a single programmatic approach.
# We want to find patterns that can be accurately described
# with a rule, such as a digit followed by a feet symbol followed by one
# or two digits followed by an inches symbol.
# To look for such patterns, it helps to remove
# the entries that are consistent with being inches,
# and view only the problematic entries.
# We write a function to automatically do this.
# We only keep entries that either result in NAs when applying as numeric
# or are outside a range of plausible heights.
# We permit a range that covers about 99.99999% of the adult population.
# We also use suppressWarnings throughout the code
# to avoid the warning messages we know the as.numeric will give us.
# So here is what the function looks like.

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

# We apply this function, and find that there are these many entries that
# are problematic.

problem <- reported_heights %>%
  filter(not_inches(height)) %>%
  .$height

length(problems)

# We can now view all the cases by simply printing them.
# We don't do that here because there are so many of them.
# But after surveying them carefully, we notice
# three patterns that are followed by three large groups of entries.
# A pattern of the form x feet y or x feet space y inches or x feet
# y backslash inches, and with x and y representing feet and inches
# respectively, is a common pattern.

# A pattern of the form x dot y or x comma y, with x feet and y inches,
# are also common.

# Entries that were reported in centimeters rather than inches
# is another example.

# Once seen that these large groups follow specific patterns,
# we can develop a plan of attack.
# Keep in mind that there is rarely just one way to perform these tasks.
# Here, we pick one that helps us teach several useful techniques.
# But surely, there is a more efficient way
# of performing the task we're about to show you.