# Import required package
library(readr)

library(tidyverse)

# File paths
file_2021 <- "data/daily_88101_2021.csv"
file_2022 <- "data/daily_88101_2022.csv"
file_2023 <- "data/daily_88101_2023.csv"

# Import the datasets
df_2021 <- read_csv(file_2021)
df_2022 <- read_csv(file_2022)
df_2023 <- read_csv(file_2023)

# Display dataset dimensions
cat("2021 dataset:", dim(df_2021), "\n")
cat("2022 dataset:", dim(df_2022), "\n")
cat("2023 dataset:", dim(df_2023), "\n")

# Display column names
cat("\nColumn names:\n")
print(names(df_2021))

# Combine the three yearly datasets
df <- bind_rows(df_2021, df_2022, df_2023)

# Display combined dataset dimensions
cat("\nCombined dataset:", dim(df), "\n")