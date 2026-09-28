import pandas as pd
import matplotlib.pyplot as plt

# Import the cleaned dataset
df = pd.read_csv("data/pm25_cleaned.csv")

# 1. MEAN AND MEDIAN OF PM2.5 CONCENTRATION

# Select PM2.5 concentration
pm25 = df["Arithmetic Mean"].dropna()

# Calculate mean and median
mean_pm25 = pm25.mean()
median_pm25 = pm25.median()

print("Measures of Central Tendency")
print("--------------------------------")
print("Variable: Arithmetic Mean (PM2.5 concentration)")
print("Number of observations:", len(pm25))

print("\nMean  :", round(mean_pm25, 2), "µg/m³")
print("Median:", round(median_pm25, 2), "µg/m³")


# 2. MODE OF SAMPLE DURATION

# Calculate frequency of each sample duration
duration_counts = df["Sample Duration"].value_counts()

# Identify the mode
mode_duration = duration_counts.idxmax()

print("\nMode")
print("--------------------------------")
print("Variable: Sample Duration")
print("Mode:", mode_duration)


# 3. HISTOGRAM OF PM2.5 WITH MEAN AND MEDIAN

# Take a random sample for visualization
# Statistics above are calculated using the complete dataset
pm25_sample = pm25.sample(
    n=100000,
    random_state=42
)

plt.figure(figsize=(9, 5))

plt.hist(
    pm25_sample,
    bins=50
)

# Mean
plt.axvline(
    mean_pm25,
    linestyle="--",
    linewidth=2,
    label=f"Mean = {mean_pm25:.2f}"
)

# Median
plt.axvline(
    median_pm25,
    linestyle="-",
    linewidth=2,
    label=f"Median = {median_pm25:.2f}"
)

plt.xlabel("PM$_{2.5}$ concentration (µg/m³)")
plt.ylabel("Frequency")
plt.title("Distribution of PM$_{2.5}$ Concentrations")
plt.legend()

plt.tight_layout()

# Save figure
plt.savefig(
    "figures/pm25_central_tendency.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# 4. BAR CHART OF SAMPLE DURATION

plt.figure(figsize=(8, 5))

plt.bar(
    duration_counts.index,
    duration_counts.values
)

# Add frequency labels
for i, value in enumerate(duration_counts.values):
    plt.text(
        i,
        value + 10000,
        f"{value:,}",
        ha="center"
    )

plt.xlabel("Sample Duration")
plt.ylabel("Number of observations")
plt.title("Frequency of PM$_{2.5}$ Sample Duration")

plt.tight_layout()

# Save figure
plt.savefig(
    "figures/sample_duration_frequency.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()

# Calculate variance
variance = pm25.var()
print("Variance of PM2.5 concentration")
print("Variance:", round(variance, 2), "(µg/m³)²")

# Calculate standard deviation
std_dev = pm25.std()
print("Standard Deviation of PM2.5 concentration")
print("Standard deviation:", round(std_dev, 2), "µg/m³")

# Calculate skewness
skewness = pm25.skew()
print("Skewness of PM2.5 concentration")
print("Skewness:", round(skewness, 4))

# Calculate excess kurtosis
kurtosis = pm25.kurt()
print("Kurtosis of PM2.5 concentration")
print("Excess kurtosis:", round(kurtosis, 4))

# Frequency Distribution of PM2.5 Concentration
import numpy as np
# Define bins (intervals of 5 units)
bins = np.arange(0, pm25.max() + 5, 5)
# Frequency count in each interval

frequency_table = pd.cut(
    pm25, bins=bins
).value_counts().sort_index()
print("\nFrequency Distribution Table:")
print(frequency_table)

#Cumulative Frequency Distribution
cumulative_frequency = frequency_table.cumsum()

print("\nCumulative Frequency Distribution Table:")
print(cumulative_frequency)

#Percentiles 

percentile_values = np.percentile(
    pm25, [25, 50, 75, 90, 95]
)

# Percentile Summary
print("\nPercentile Summary of PM2.5 Concentration:")
print("25th Percentile:", percentile_values[0])
print("50th Percentile (Median):", percentile_values[1])
print("75th Percentile:", percentile_values[2])
print("90th Percentile:", percentile_values[3])
print("95th Percentile:", percentile_values[4])