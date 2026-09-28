library(tidyverse)

# Import the cleaned dataset
df <- read_csv("data/pm25_cleaned.csv")


# 1. MEAN AND MEDIAN OF PM2.5 CONCENTRATION

# Select PM2.5 concentration
pm25 <- df$`Arithmetic Mean`

# Remove missing values
pm25 <- pm25[!is.na(pm25)]

# Calculate mean and median
mean_pm25 <- mean(pm25)
median_pm25 <- median(pm25)

cat("Measures of Central Tendency\n")
cat("--------------------------------\n")
cat("Variable: Arithmetic Mean (PM2.5 concentration)\n")
cat("Number of observations:", length(pm25), "\n")

cat("\nMean  :", round(mean_pm25, 2), "µg/m³\n")
cat("Median:", round(median_pm25, 2), "µg/m³\n")

# 2. MODE OF SAMPLE DURATION

# Calculate frequency of each sample duration
duration_counts <- table(df$`Sample Duration`)

# Identify the mode
mode_duration <- names(duration_counts)[
  which.max(duration_counts)
]

cat("\nMode\n")
cat("--------------------------------\n")
cat("Variable: Sample Duration\n")
cat("Mode:", mode_duration, "\n")

# 3. HISTOGRAM OF PM2.5 WITH MEAN AND MEDIAN

# Take a random sample for visualization
# Statistics above are calculated using the complete dataset
set.seed(42)

pm25_sample <- sample(
  pm25,
  size = 100000
)

# Create data frame for plotting
plot_data <- data.frame(
  PM25 = pm25_sample
)

# Create histogram
ggplot(plot_data, aes(x = PM25)) +
  geom_histogram(bins = 50) +
  geom_vline(
    xintercept = mean_pm25,
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = median_pm25,
    linewidth = 1
  ) +
  labs(
    title = "Distribution of PM2.5 Concentrations",
    x = "PM2.5 concentration (µg/m³)",
    y = "Frequency"
  ) +
  theme_minimal()

# Save figure
ggsave(
  "figures/pm25_central_tendency_R.png",
  width = 9,
  height = 5,
  dpi = 300
)

# 4. BAR CHART OF SAMPLE DURATION

# Convert frequency table to data frame
duration_data <- as.data.frame(duration_counts)

names(duration_data) <- c(
  "Sample_Duration",
  "Frequency"
)

# Create bar chart
ggplot(
  duration_data,
  aes(
    x = Sample_Duration,
    y = Frequency
  )
) +
  geom_col() +
  geom_text(
    aes(label = format(Frequency, big.mark = ",")),
    vjust = -0.3
  ) +
  labs(
    title = "Frequency of PM2.5 Sample Duration",
    x = "Sample Duration",
    y = "Number of observations"
  ) +
  theme_minimal()

# Save figure
ggsave(
  "figures/sample_duration_frequency_R.png",
  width = 8,
  height = 5,
  dpi = 300
)

# Calculate variance
variance <- var(pm25)
cat("Variance of PM2.5 concentration\n")
cat("Variance:", round(variance, 2), "(µg/m³)²\n")

# Calculate standard deviation
std_dev <- sd(pm25)
cat("Standard Deviation of PM2.5 concentration\n")
cat("Standard deviation:", round(std_dev, 2), "µg/m³\n")

# Calculate skewness
library(moments)
skewness <- skewness(pm25)
cat("Skewness of PM2.5 concentration\n")
cat("Skewness:", round(skewness, 4), "\n")

#Kurtosis
kurtosis_value <- kurtosis(pm25) - 3
cat("Kurtosis of PM2.5 concentration\n")
cat("Excess kurtosis:", round(kurtosis_value, 4), "\n")

# Frequency Distribution of PM2.5 Concentration

# Define bins (intervals of 5 units)
bins <- seq(
  0,
  max(pm25) + 5,
  by = 5
)
# Frequency count in each interval
frequency_table <- table(
  cut(
    pm25,
    breaks = bins
  )
)
cat("\nFrequency Distribution Table:\n")
print(frequency_table)

#Cumulative Frequency Distribution
cumulative_frequency <- cumsum(frequency_table)

cat("\nCumulative Frequency Distribution Table:\n")
print(cumulative_frequency)

percentile_values <- quantile(
  pm25,
  probs = c(0.25, 0.50, 0.75, 0.90, 0.95),
  na.rm = TRUE
)

cat("\nPercentile Summary of PM2.5 Concentration:\n")
cat("25th Percentile:", percentile_values[1], "\n")
cat("50th Percentile (Median):", percentile_values[2], "\n")
cat("75th Percentile:", percentile_values[3], "\n")
cat("90th Percentile:", percentile_values[4], "\n")
cat("95th Percentile:", percentile_values[5], "\n")