# Examples and explanatory Text on joins
@
library(dbplyr)
library(tidyverse)

# Read in the tables using the csv function
tab1 <- read_csv("murders")
tab2 <- read_csv("electoral-votes")

# Now perform a normal left join
left_join(tab1,tab2)

# We can also use the pipe, like this:
tab1 %>% left_join(tab2)

# Now a right join
tab1 %>% right_join(tab2)

# Use inner join to get just the rows common to both tables
inner_join(tab1, tab2)
# A full join is a union of the tables like this
full_join(tab1, tab2)

# The semi join function lets us keep the part of the first table 
# for which we have information in the second. It does not add the 
# columns of the second.
semi_join(tab1, tab2)

# The function anti join is the opposite of semi join. It keeps the 
# elements of the first table for which there is no information in
# the second.
anti_join(tab1, tab2)
