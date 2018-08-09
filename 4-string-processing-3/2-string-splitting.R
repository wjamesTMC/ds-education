library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(pdftools)

# Another very common data wrangling operation is string splitting.
# We start with an example. Suppose we did not have read_csv() available.
# Instead, we have to use the base R function readLines like this:

filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)

# This function reads in the data line by line to create a vector of
# strings like rows in a spreadsheet. The first 6 lines are these:
  
lines %>% head()

# [1] "state,abb,region,population,total"
# [2] "Alabama,AL,South,4779736,135"     
# [3] "Alaska,AK,West,710231,19"         
# [4] "Arizona,AZ,West,6392017,232"      
# [5] "Arkansas,AR,South,2915918,93"     
# [6] "California,CA,West,37253956,1257" 

# We want to extract the variables that are separate by commas.
# The function str_split does just that.

x <- str_split(lines, ",")
x %>% head()

# [[1]]
# [1] "state"      "abb"        "region"     "population" "total"     

# [[2]]
# [1] "Alabama" "AL"      "South"   "4779736" "135"    

# [[3]]
# [1] "Alaska" "AK"     "West"   "710231" "19"    

# [[4]]
# [1] "Arizona" "AZ"      "West"    "6392017" "232"    

# [[5]]
# [1] "Arkansas" "AR"       "South"    "2915918"  "93"      

# [[6]]
# [1] "California" "CA"         "West"       "37253956"   "1257"

# Note that the first entry has the column names. We can separate
# that out like this:
  
col_names <- x[[1]]
x <- x[-1]

# To convert this into a data frame, we can use a short-cut,
# the map() function in the purrr function. So if we want to 
# extract the first entry of each element, we can write this
# code using the map function:

library(purrr)
map(x, function(y) y[1]) %>% head
# [[1]]
# [1] "Alabama"

# [[2]]
# [1] "Alaska"

# [[3]]
# [1] "Arizona"

# [[4]]
# [1] "Arkansas"

# [[5]]
# [1] "California"

# [[6]]
# [1] "Colorado"

# However, because this is a common task, purrr provides a 
# shortcut so the code is simpler; we can write this:

map(x, 1) %>% head

# To force map to return a character vector instead of a list,
# we can use map_chr(). Similarly, map_int(). So to create our
# dateframe, we can use the following code:

dat <- data.frame(map_chr(x, 1),
                  map_chr(x, 2),
                  map_chr(x, 3),
                  map_chr(x, 4),
                  map_chr(x, 5)) %>%
    mutate_all(parse_guess) %>%
    setNames(col_names)
dat %>% head
# state abb region population total
# 1      Alabama AL     South  4779736  135
# 2      Alaska AK      West   710231   19
# 3     Arizona AZ      West  6392017  232
# 4    Arkansas AR     South  2915918   93
# 5  California CA      West 37253956 1257
# 6    Colorado CO      West  5029196   65

# Note that using other functions in the purrr package can
# accomplish things with much less code - here is an example:

dat <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>%
  as.data.frame()

# It turns out we could have avoided all this because in the 
# function str_split there is an argument called simplify = TRUE
# that forces the function to return a matrix instead of a list.
# So we could have written thnis:

x <- str_split(lines, ",", simplify = TRUE)
col_names <- x[1,]
x <- x[-1,]
x %>% as.data.frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)