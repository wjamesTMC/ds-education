library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
install.packages("htmlwidgets")

data("reported_heights")
setwd("C:/Users/jamesw/Documents/ds-education")

convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
    str_replace_all("inches|in|''|\"|cm|and", "") %>%  #remove inches and other symbols
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>% #change x.y, x,y x y
    str_replace("^([56])'?$", "\\1'0") %>% #add 0 when to 5 or 6
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>% #change european decimal
    str_trim() #remove extra space
}

words_to_numbers <- function(s){
  str_to_lower(s) %>%  
    str_replace_all("zero", "0") %>%
    str_replace_all("one", "1") %>%
    str_replace_all("two", "2") %>%
    str_replace_all("three", "3") %>%
    str_replace_all("four", "4") %>%
    str_replace_all("five", "5") %>%
    str_replace_all("six", "6") %>%
    str_replace_all("seven", "7") %>%
    str_replace_all("eight", "8") %>%
    str_replace_all("nine", "9") %>%
    str_replace_all("ten", "10") %>%
    str_replace_all("eleven", "11")
}

converted <- problems %>% words_to_numbers %>% convert_format
remaining_problems <- converted[not_inches_or_cm(converted)]
pattern <- "^[4-7]\\s*'\\s*\\d+\\.?\\d*$"
index <- str_detect(remaining_problems, pattern)
remaining_problems[!index]

s <- c("5'10", "6'1\"", "5'8inches", "5'7.5")
tab <- data.frame(x = s)

# Answer 1 - syntax is wrong
extract(data = tab, col = x, into = c(“feet”, “inches”, “decimal”), 
        regex = "(\\d)'(\\d{1,2})(\\.)?"
        
        # Answer 2 - syntax is wrong
        extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
                regex = "(\\d)'(\\d{1,2})(\\.\\d+)")
        
        # Answer 3 - syntax is wrong
        extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
                regex = "(\\d)'(\\d{1,2})\\.\\d+?"
                
                # Answer 4 - Correct: {{In this code, you extract three groups: one 
                # digit for “feet”, one or two digits for “inches”, and an optional 
                # decimal point followed by at least one digit for “decimal”. }}
                
                extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
                        regex = "(\\d)'(\\d{1,2})(\\.\\d+)?")  