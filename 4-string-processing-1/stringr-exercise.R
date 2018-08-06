library(tidyverse)

filename <- "stringr-exercise.txt"
d <- read_tsv(filename)
head(d)

d %>% mutate_at(2:3, parse_number)
d
d %>% mutate_at(2:3, as.numeric)
d
d %>% mutate_all(parse_number)
d
d %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% mutate_at(2:3, as.numeric)
d