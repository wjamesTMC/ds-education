library(dplyr)

df_1 <- read_csv("df1")
df_2 <- read_csv("df2")

final <- union(df_1, df_2)
final
final <- setdiff(df_1, df_2)
final
final <- setdiff(df_2, df_1)
final
final <- intersect(df_1, df_2)
final