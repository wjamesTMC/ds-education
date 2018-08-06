library(tidyverse)
library(dbplyr)
tab1 <- read_csv("tab1")
tab2 <- read_csv("tab2")

dat <- semi_join(tab1, tab2, by = "state")
dim(dat)

#dat <- left_join(tab1, tab2, by = "state")
#dim(dat)
