# Video and sample code for stringr package 

library(tidyverse)
library(rvest)
library(readr)

# Get the file we are going to use
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
tab <- h %>% html_nodes("table")
tab <- tab[[2]]
tab
tab <- tab %>% html_table
tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

# At this point we have a table with characters for numbers
# with commas in them

# In R, we usually store strings in a character vector.
# In a previous video, we created an object called murders
# by scraping a table from the web.The population column 
# has a character vector.
# The first three strings in this vector defined by the 
# population variable can be seen here. Note that the usual 
# coercion to convert numbers doesn't work here. Look at what happens.
# This is because of the commas. # The string processing we want 
# to do here is to remove the pattern comma from # the string in 
# murders_raw$population and then coerce the numbers.

# The readr package includes a function that detects and replaces
# commas in the given column
tab_new <- parse_number(tab$population)
tab_new %>% head

tab_new <- tab %>% mutate_at(2:3, parse_number)
tab_new %>% head
