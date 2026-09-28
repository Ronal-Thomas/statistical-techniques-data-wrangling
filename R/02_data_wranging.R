library(tidyverse)

# Import the combined dataset
df <- read_csv("data/combined_pm25_2021_2023.csv")

# Dataset dimensions
cat("Dataset dimensions:\n")
print(dim(df))

# Variable names
cat("\nVariable names:\n")
print(names(df))

# Data types
cat("\nData types:\n")
print(sapply(df, class))

# Missing values
cat("\nMissing values:\n")
print(colSums(is.na(df)))

# Summary statistics
cat("\nSummary statistics:\n")
print(summary(df))


# Calculate missing-value percentages
missing_percent <- colMeans(is.na(df)) * 100


# Keep only variables with missing values
missing_percent <- missing_percent[missing_percent > 0]

# Sort from highest to lowest
missing_percent <- sort(missing_percent, decreasing = FALSE)

# Convert to a data frame for plotting
missing_df <- data.frame(
  Variable = names(missing_percent),
  Percentage = as.numeric(missing_percent)
)

# Create the plot
ggplot(missing_df, aes(
  x = Percentage,
  y = reorder(Variable, Percentage)
)) +
  geom_col() +
  geom_text(
    aes(label = sprintf("%.2f%%", Percentage)),
    hjust = -0.1
  ) +
  labs(
    title = "Percentage of Missing Values in the PM2.5 Dataset",
    x = "Missing values (%)",
    y = "Variable"
  ) +
  xlim(0, 80) +
  theme_minimal()

# Save the figure
ggsave(
  "figures/missing_values_percentage_R.png",
  width = 9,
  height = 5,
  dpi = 300
)


# Handling Missing Values 

# Replace missing categorical metadata with "Unknown"
df$`Local Site Name` <- 
  replace_na(df$`Local Site Name`, "Unknown")

df$Address <- 
  replace_na(df$Address, "Unknown")

df$`CBSA Name` <- 
  replace_na(df$`CBSA Name`, "Unknown")

# Check missing values after treatment
missing_after <- colSums(is.na(df))

cat("Missing values after treatment:\n")
print(missing_after[missing_after > 0])

# Save the cleaned dataset
write_csv(
  df,
  "data/pm25_cleaned.csv"
)

# Identify exact duplicate rows
duplicate_count <- sum(duplicated(df))

cat("\nNumber of exact duplicate rows:\n")
print(duplicate_count)

 # transformation of date variable
df$`Date Local` <- as.Date(df$`Date Local`)

df$Year <- as.integer(format(df$`Date Local`, "%Y"))

df$Month <- as.integer(format(df$`Date Local`, "%m"))