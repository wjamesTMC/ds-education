library(tidyverse)
d <- read_csv("wrangling-ex-aq1.csv")
head(d)

tidy_data <- d %>% gather(key, value, -age_group) %>%
  separate(col = key, into = c("year", "variable_name"), sep = ".") %>% 
  spread(key = variable_name, value = value)
