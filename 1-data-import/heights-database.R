library(dslabs)
library(tidyverse)

data("reported_heights")

class(reported_heights$height)
x <- as.numeric(reported_heights$height)
x
head(x)
sum(is.na(x))

# So we could fix all the problematic entries by hand.
# However, humans are prone to making mistakes.
# Also, because we plan on continuing to collect data going forward,
# it'll be convenient to write code that automatically does this.
# A first step in this type of task is to survey the problematic entries
# and try to define specific patterns followed by a large group of entries.
# The larger these groups, the more entries
# we can fix with a single programmatic approach.

reported_heights %>% mutate(new_height = as.numeric(height)) %>% filter(is.na(new_height)) %>% head(n=10)

# We can write a function to isolate on all these problems - We only keep entries that either 
# result in NAs when applying as.numeric or are outside a range of plausible heights.
# We permit a range that covers about 99.99999% of the adult population.

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  print(ind)
}

problems <- reported_heights %>% filter(not_inches(height)) %>% .$height
head(problems)
length(problems)
