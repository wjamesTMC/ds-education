library(tidyverse)
library(dslabs)
library(dplyr)

# You need to be in the working directory of your choice

path <- system.file("extdata",package="dslabs")
list.files(path)

# Copy life expectancy files
filename <- "life-expectancy-and-fertility-two-countries-example.csv"
fullpath <- file.path(path, filename)
fullpath
file.copy(fullpath, getwd())

# Copy fertility file
filename <- "fertility-two-countries-example.csv"
fullpath <- file.path(path, filename)
fullpath
file.copy(fullpath, getwd())

# Copy murders  file
filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath
file.copy(fullpath, getwd())