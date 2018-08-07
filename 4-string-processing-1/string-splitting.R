library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(purrr)
install.packages("htmlwidgets")
install.packages("purrr")


data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)

# What if you did not have read_csv() available? We could use
# the base function lines, like this:

lines %>% head()

# One row for each line in the file. We can use str_wplit() to extract
# the values separated by commas

x <- str_split(lines, ",")
x %>% head()

# The first row has column names. We can separate that out like this:

col_names <- x[[1]]
x <- x[-1]

# To convert our list to a dataframe we use the map() function in the 
# purrr package

map(x, function(y) y[1]) %>% head()

# The package provides a shortcut for the function

map(x, 1) %>% head()

# To force map to return a character vector, we can use map_chr()
# Similarly, we can use map_int() to return integers
# To create our data frame, we can use the following code:

dat <- data.frame(map_chr(x, 1),
                  map_chr(x, 2),
                  map_chr(x, 3),
                  map_chr(x, 4),
                  map_chr(x, 5)) %>%
  mutate_all(parse_guess) %>%
  setNames(col_names)
dat %>% head()

#        state abb region population total
# 1    Alabama  AL  South    4779736   135
# 2     Alaska  AK   West     710231    19
# 3    Arizona  AZ   West    6392017   232
# 4   Arkansas  AR  South    2915918    93
# 5 California  CA   West   37253956  1257
# 6   Colorado  CO   West    5029196    65

# We could use other functions in the purrr package to write more
# efficient code - like this:

dat <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>%
  as.data.frame()
dat %>% head()

# In str_split(), there is a function that returns a matrix instead
# of a list. The code looks like this:

filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)

x <- str_split(lines, ",", simplify = TRUE)
col_names <- x[1,]
x <- x[-1,]
x %>% as_data_frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)

# A tibble: 51 x 5
# state                abb   region    population total
# <chr>                <chr> <chr>          <int> <int>
# 1 Alabama              AL    South        4779736   135
# 2 Alaska               AK    West          710231    19
# 3 Arizona              AZ    West         6392017   232
# 4 Arkansas             AR    South        2915918    93
# 5 California           CA    West        37253956  1257
# 6 Colorado             CO    West         5029196    65
# 7 Connecticut          CT    Northeast    3574097    97
# 8 Delaware             DE    South         897934    38
# 9 District of Columbia DC    South         601723    99
# 10 Florida              FL    South       19687653   669
# ... with 41 more rows