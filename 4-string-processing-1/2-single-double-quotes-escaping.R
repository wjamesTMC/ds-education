# Video and sample code for string functions

library(tidyverse)
library(rvest)

# Since web pages and other formal documents use commas in numbers
# to improve readability.
# For example, we write the number 4,853,875 like this.
# And it's easier to read than writing it like this with no commas.
# Because this is such a common task, there's already a function,
# parse_number(), that readily does this conversion.

# Now, what happens if your string includes double quotes?
#   For example, if you want to write 10 inches like this--
#   "10""
# for this we have to use single quotes.
# You can't use this code, because this is just the string
# 10 followed by a double quote.
# If you type this into R you get an error,
# because you have an unclosed double quote.
# So to avoid this, we can use the single quotes like this.
# To make sure that it's working, in R we can use the function cat.
# The function cat lets us see what the string actually looks like.
# So if we type cat(s), we will see 10" as we wanted.

# Now, what do we want to use string to be 5 feet written like this--
#  5'
# 5 and then the single quote.
# In this case we use the double quotes like this--
# "5'"
# you can see it works by using cat().
# So we've learn how to write five feet and 10 inches separately.
# But what if we want to write them together to represent
# five feet and 10 inches, like this?
# In this case, neither the single or a double quote will work.

# *** USE OF ESCAPE CHARACTERS ***
# We have to escape the character like this:
s <- '5\'10"'
cat(s)

# Escaping characters is something we often have to do in strings.

cat(" LeBron James is 6'8\" ")

# The following all generate errors because they are misformed
cat(' LeBron James is 6'8" ')
cat(` LeBron James is 6'8" `)
cat(" LeBron James is 6\'8" ")
