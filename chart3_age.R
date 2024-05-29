library(dplyr)
library(ggplot2)
library(plotly)

# Load the dataframe
data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/exploratory-analysis-anushkaamalpani/main/data.csv")

# Function to create the plot for a given year
create_ageism_plot <- function(year) {
  # Filter for the United States
  us_data <- filter(data, country_name == "United States")
  
  # Select only the columns for age categories and the given year
  year_col <- paste0("X", year)
  us_year <- us_data %>%
    select(age_categories, !!sym(year_col))
  
  # Calculate the average unemployment rate for each age category for the given year
  us_avg_year <- us_year %>%
    group_by(age_categories) %>%
    summarise(avg_unemployment_rate = mean(!!sym(year_col), na.rm = TRUE))
  
  # Reorder the levels of age_categories variable
  us_avg_year$age_categories <- factor(us_avg_year$age_categories, levels = c("Children", "Youth", "Adults"))
  
  # Create the barplot using ggplot2
  us_avg_year_graph <- ggplot(us_avg_year, aes(x = age_categories, y = avg_unemployment_rate, fill = age_categories, text = paste("Unemployment Rate: ", round(avg_unemployment_rate, 2)))) +
    geom_bar(stat = "identity") +
    labs(title = paste("Age Categories vs Average Unemployment Rate in the US for", year),
         x = "Age Category",
         y = "Average Unemployment Rate",
         fill = "Age Category") +
    theme_minimal() +
    theme(legend.position = "none")
    geom_text(aes(label = round(avg_unemployment_rate, 2)), vjust = -0.5)
  
  return(us_avg_year_graph)
}

create_ageism_plot(2018)

# Extract column names starting with "X"
year_columns <- grep("^X", colnames(data), value = TRUE)

# Extract numeric part (years) from column names
years <- as.numeric(gsub("X", "", year_columns))

# Find the minimum and maximum years
year_range <- range(years)
