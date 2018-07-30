# Set Operators
#
# Another set of commands useful for combining data are the set operators.
# When applied to vectors, these behave as their name suggests-- union, 
# intersect, et cetera. And we're going to see examples soon. However, if 
# the tidyverse, or, more specifically, dplyr is loaded, these functions 
# can be used on data frames, as opposed to just on vectors.

library(tidyverse)
library(dplyr)

intersect(1:10, 6:15)

# But with dplyr loaded, we can also do this for tables. It'll take the 
# intersection of rows for tables having the same column names.

tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
intersect(tab1, tab2)

# So if we take the first five rows of tab and rows three through seven of 
# tabs, and we take the intersection, it will give us rows three, four, 
# and five,

# Similarly, union takes the union. If you apply it to vectors, you get 
# the union like this. But with dplyr loaded, we can also do this for 
# tables having the same column names.

tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
union(tab1, tab2)

# #We can also take set differences using the function setdiff. Unlike 
# intersect and union, this function is not symmetric. For example, note 
# that you get two different answers if you switch the arguments.

setdiff(1:10, 6:15)
setdiff(6:16, 1:10)

# And again, with dplyr loaded, we can apply this to data frames.
# Look what happens when we take the setdiff of tab one and tab two.

tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
setdiff(tab1, tab2)

# Finally, the function setequal tells us if two sets are the same 
# regardless of order. So for example, if I do set equals of one through 
# five and one through six, I get false, because they're not the same vectors.
# But if I take set equals of one through five and five through one,
# I get true, because if you ignore order, these are the same vectors.
# With dplyer loaded, we can use this on data frames, as well.
# When applied to data frames that are not equal, regardless of order,

setequal(1:5, 1:6)
setequal(1:5, 5:1)
setequal(tab1, tab2)
