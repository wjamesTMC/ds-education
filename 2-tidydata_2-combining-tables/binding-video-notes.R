library(tidyverse)
library(dplyr)

# The dplyr function bind_cols binds two objects by putting the columns 
# of each together in a table.

bind_cols(a = 1:3, b = 4:6)

# Note that there's an r-based function, cbind, that performs the same 
# function but creates objects other than tibbles, either matrices or 
# data frames, something else. Bind_cols can also bind data frames.
# For example, here we break up the tab data frame and then bind them 
# back together.

tab <- read_csv("start-table")
head(tab)

tab1 <- tab[, 1:3]
tab2 <- tab[, 4:6]
tab3 <- tab[, 7:9]

new_tab <- bind_cols(tab1, tab2, tab3)
head(new_tab)

# The bind_rows is similar, but binds rows instead of columns.

tab1 <- tab[1:2,]
tab2 <- tab[3:4,]
bind_rows(tab1, tab2)
