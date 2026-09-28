import pandas as pd

# File paths
file_2021 = "data/daily_88101_2021.csv"
file_2022 = "data/daily_88101_2022.csv"
file_2023 = "data/daily_88101_2023.csv"


# Import the datasets
df_2021 = pd.read_csv(file_2021)
df_2022 = pd.read_csv(file_2022)
df_2023 = pd.read_csv(file_2023)

# Display dataset dimensions
print("2021 dataset:", df_2021.shape)
print("2022 dataset:", df_2022.shape)
print("2023 dataset:", df_2023.shape)

# Display column names
print("\nColumn names:")
print(df_2021.columns.tolist())

# Combine the three yearly datasets
df = pd.concat(
    [df_2021, df_2022, df_2023],
    ignore_index=True
)

# Display combined dataset dimensions
print("\nCombined dataset:", df.shape)
df.to_csv("data/combined_pm25_2021_2023.csv", index=False)

