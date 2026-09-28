import pandas as pd

# Import the combined dataset
df = pd.read_csv("data/combined_pm25_2021_2023.csv")
# Dataset dimensions
print("Dataset dimensions:")
print(df.shape)

# Variable names
print("\nVariable names:")
print(df.columns.tolist())

# Data types
print("\nData types:")
print(df.dtypes)

# Missing values
print("\nMissing values:")
print(df.isnull().sum())

# Summary statistics
print("\nSummary statistics:")
print(df.describe())

# plotting of Missing Values

import matplotlib.pyplot as plt


# Calculate missing-value percentages
missing_percent = (
    df.isnull().mean() * 100
)

# Keep only variables with missing values
missing_percent = missing_percent[missing_percent > 0]

# Sort from highest to lowest
missing_percent = missing_percent.sort_values(ascending=True)

# Create the plot
plt.figure(figsize=(9, 5))

plt.barh(
    missing_percent.index,
    missing_percent.values
)

# Add percentage labels
for i, value in enumerate(missing_percent.values):
    plt.text(
        value + 1,
        i,
        f"{value:.2f}%",
        va="center"
    )

plt.xlabel("Missing values (%)")
plt.ylabel("Variable")
plt.title("Percentage of Missing Values in the PM$_{2.5}$ Dataset")

plt.xlim(0, 80)
plt.tight_layout()

# Save the figure
plt.savefig(
    "figures/missing_values_percentage.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()

# Handling missing Values.
# Replace missing categorical metadata with "Unknown"
df["Local Site Name"] = df["Local Site Name"].fillna("Unknown")
df["Address"] = df["Address"].fillna("Unknown")
df["CBSA Name"] = df["CBSA Name"].fillna("Unknown")

# Check missing values after treatment
missing_after = df.isnull().sum()

print("Missing values after treatment:")
print(missing_after[missing_after > 0])

# Save the dataset
df.to_csv(
    "data/pm25_cleaned.csv",
    index=False
)

# Identify exact duplicate rows
duplicate_count = df.duplicated().sum()

print("\nNumber of exact duplicate rows:")
print(duplicate_count)

print("Sample Duration:")
print(df["Sample Duration"].value_counts())

print("\nUnits of Measure:")
print(df["Units of Measure"].value_counts())

df["Date Local"] = pd.to_datetime(df["Date Local"])
df["Year"] = df["Date Local"].dt.year
df["Month"] = df["Date Local"].dt.month

df.shape