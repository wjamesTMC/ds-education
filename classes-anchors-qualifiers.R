library(tidyverse)
install.packages("htmlwidgets")
pattern <- "^\\d$"
yes <- c("1", "5", "9")
no <- c("12", "123", "1", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)