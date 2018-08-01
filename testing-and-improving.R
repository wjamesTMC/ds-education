library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

# Let's write a function that captures all the entries that
# can't be converted into numbers, remembering
# that some are in centimeters.
# We'll deal with those later.

not_inches_or_cm <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) & 
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

problems <- reported_heights %>% filter(not_inches_or_cm(height)) %>% .$height
length(problems)

# Here, we leverage the pipe--  one of the advantages of using a stringr.
# We use the pipe to concatenate the different replacements
# that we have just performed.

# Then we define the pattern and then, we go and try to see how many we match.

converted <- problems %>%
  str_replace("feet|foot|ft", "'") %>%
  str_replace("inches|in|''|\"", "") %>%
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
converted

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"  # Note curly brackets near the end
index <- str_detect(converted, pattern)
index
mean(index)

# [1] 0.615
# We are matching over half now. Let's go after the rest of the cases
# One problem is that people exactly 5 or 6 feet did not enter inches

# Some of the inches were entered with decimal points.
# For example, 5 feet and 7.5 inches. Our pattern only looks for two digits.
# We also have cm, European punctuation, etc.
# It may not be worthwhile to fix them

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
converted_2 <- problems %>% str_replace(converted, pattern)
converted_2 <- problems %>% "^[4-7]\\s*'\\s*\\d{1,2}$"
converted_2

converted <- problems %>%