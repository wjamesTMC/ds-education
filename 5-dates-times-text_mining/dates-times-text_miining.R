library(tidyverse)
library(dslabs)
library(readr)
library(readxl)
library(pdftools)
library(lubridate)

install.packages("htmlwidgets")

setwd("C:/Users/jamesw/Documents/ds-projects-edu")

# DATES SECTION

# R established specific data types for dates and times. They may look like
# strings, but they are not. For example:

data("polls_us_election_2016")
polls_us_election_2016$startdate %>% head
class(polls_us_election_2016)

# [1] "2016-11-03" "2016-11-01" "2016-11-02" "2016-11-04" "2016-11-03" "2016-11-03"
# [1] "Date"

# Plotting functions such as those into GPlot are aware days.
# This means that, for example, a scatterplot
# can use a numeric representation to decide on the position of the point,
# but include the string and the labels.

# Dates are so common that R has a library(lubridate). Here is a random sampling
# of dates and what you can do with them

set.seed(2)
dates <- sample(polls_us_election_2016$startdate, 10) %>% sort
dates

# The functions year month day extract those values

data.frame(date = days(dates),
           month = month(dates),
           day = day(dates),
           year = year(dates))

# Extracting the month label

month(dates, label = TRUE)

# The parsers convert strings into dates

x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")
ymd(x)

# Dates can be written in different formats. The ISO 8601 format is YYYY-MM-DD
# so things sort alphabetically

# When dates are ambiguous like 09/01/02, you can examine the vector to determine
# the general format being used. For example, if the string is 09/01/02, the 
# ymd function assumes the first entry is a year, the second is a month, and the 
# third is a day.

x <- "09/01/02"
ymd(x)
ydm(x)
myd(x)
dmy(x)
dym(x)

# TIME SECTION - Using lubridate with time (Sys.time())
Sys.time()

# now() gives you the time zone
now()
now("GMT")

# All the available timezones are available through the OlsonNames function

OlsonNames()

# You can also extract hours minutes, and seconds

now() %>% hour()
now() %>% minute()
now() %>% second()

# It can also parse strings into times

x <- c("12:34:56")
hms(x)

x <- "Nov/2/2012 12:34:56"
mdy_hms(x)

# Exercises
dates <- c("09-01-02", "01-12-07", "02-03-04")

ymd(dates)
mdy(dates)
dmy(dates)

# TEXT MINING SECTION - see separate file (case study)

