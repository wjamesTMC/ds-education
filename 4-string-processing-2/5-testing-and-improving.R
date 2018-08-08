library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")

# We have developed a powerful string processing technique that can help 
# us catch many of the problematic entries. Now, it's time to test our approach, search for further problems,
# and tweak our approach for possible improvements.

# Let's write a function that captures all the entries that
# can't be converted into numbers, remembering # that some 
# are in centimeters. We'll deal with those later.

not_inches_or_cm <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) & 
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

problems <- reported_heights %>% filter(not_inches_or_cm(height)) %>% .$height
length(problems)

# Here, we leverage the pipe--one of the advantages of using a stringr.
# We use the pipe to concatenate the different replacements # that we have 
# just performed. Then we define the pattern and then, we go and try to see 
# how many we match.

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

# We are matching over half now. Let's go after the rest of the cases.

converted[!index]
# [1] "6"             "165cm"         "511"           "6"             "2"            
# [6] ">9000"         "5 ' and 8.11 " "11111"         "6"             "103.2"        
# [11] "19"            "5"             "300"           "6'"            "6"            
# [16] "Five ' eight " "7"             "214"           "6"             "0.7"          
# [21] "6"             "2'33"          "612"           "1,70"          "87"           
# [26] "5'7.5"         "5'7.5"         "111"           "5' 7.78"       "12"           
# [31] "6"             "yyy"           "89"            "34"            "25"           
# [36] "6"             "6"             "22"            "684"           "6"            
# [41] "1"             "1"             "6*12"          "87"            "6"            
# [46] "1.6"           "120"           "120"           "23"            "1.7"          
# [51] "6"             "5"             "69"            "5' 9 "         "5 ' 9 "       
# [56] "6"             "6"             "86"            "708,661"       "5 ' 6 "       
# [61] "6"             "649,606"       "10000"         "1"             "728,346"      
# [66] "0"             "6"             "6"             "6"             "100"          
# [71] "88"            "6"             "170 cm"        "7,283,465"     "5"            
# [76] "5"             "34"           

# One problem is that people exactly 5 or 6 feet did not enter inches
# Some of the inches were entered with decimal points.
# For example, 5 feet and 7.5 inches. Our pattern only looks for two digits.
# We also have spaces at the end, cm, some are in European punctuation, etc.
# It is not necessarily clear that it is worth writing code to handle all 
# these cases since they might be rare enough.