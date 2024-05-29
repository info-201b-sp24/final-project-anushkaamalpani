
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(tidyverse) # This includes ggplot2, dplyr, tidyr, readr, and others
library(readr)
library(sf)
library(maps)
library(dplyr)
library(ggiraph)
library(plotly)


data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/final-project-anushkaamalpani/main/data.csv")

#chart1_covid

plot_unemployment_rate <- function(country_name) {
  
  # Filter data for the specified country
  country_data <- data %>% filter(country_name == !!country_name)
  
  # Group by sex and calculate average unemployment rates for each year
  avg_unemployment_rates <- country_data %>%
    group_by(sex) %>%
    summarise(
      avg_unemployment_rate_2017 = mean(X2017, na.rm = TRUE),
      avg_unemployment_rate_2018 = mean(X2018, na.rm = TRUE),
      avg_unemployment_rate_2019 = mean(X2019, na.rm = TRUE),
      avg_unemployment_rate_2020 = mean(X2020, na.rm = TRUE),
      avg_unemployment_rate_2021 = mean(X2021, na.rm = TRUE),
      avg_unemployment_rate_2022 = mean(X2022, na.rm = TRUE)
    )
  
  # Convert data into long format for ggplot
  data_long <- pivot_longer(avg_unemployment_rates, 
                            cols = starts_with("avg_unemployment_rate"),
                            names_to = "year", 
                            names_prefix = "avg_unemployment_rate_",
                            values_to = "avg_unemployment_rate")
  
  # Create the line graph
  ggplot(data_long, aes(x = year, y = avg_unemployment_rate, color = sex, group = sex)) +
    geom_line() +
    labs(x = "Year", y = "Average Unemployment Rate", title = paste("Average Unemployment Rate by Sex in", country_name)) +
    theme_minimal() +
    scale_x_discrete(labels = c("2017", "2018", "2019", "2020", "2021", "2022")) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

# Example usage
plot_unemployment_rate("Canada")

#chart2_tropics

create_unemployment_plot <- function(year) {
  
  world_map <- map_data("world")
  
  # Averaging unemployment rate for the specified year
  avg_unemployment_rate_col <- paste0("X", year)
  q2_year <- data %>%
    group_by(country_name) %>%
    summarise(avg_unemployment_rate = mean(!!sym(avg_unemployment_rate_col), na.rm = TRUE))
  
  # Making sure country names match up
  country_name_fixes <- list(
    "Russia" = 140,
    "USA" = 180,
    "Democratic Republic of the Congo" = 39,
    "Republic of Congo" = 38,
    "Tanzania" = 167,
    "Venezuela" = 185,
    "Iran" = 78,
    "North Korea" = 89,
    "South Korea" = 90,
    "Laos" = 93,
    "Taiwan" = 165,
    "Vietnam" = 186,
    "Brunei" = 23,
    "Moldova" = 111,
    "Palestine" = 129,
    "Syria" = 164,
    "UK" = 179,
    "Czech Republic" = 44
  )
  
  for (name in names(country_name_fixes)) {
    q2_year[country_name_fixes[[name]], 1] <- name
  }
  
  # Join with world map data
  country_geometry_year <- inner_join(q2_year, world_map, by = c("country_name" = "region"))
  country_geometry_year <- country_geometry_year %>%
    select(-"group", -"order", -"subregion")
  
  # Creating the plot
  gg <- ggplot(country_geometry_year) + 
    geom_map_interactive(data = world_map, map = world_map, 
                         aes(map_id = region, tooltip = region), fill = "yellowgreen", color = "white") + 
    geom_map_interactive(map = world_map, 
                         aes(map_id = country_name, fill = avg_unemployment_rate, 
                             tooltip = paste(country_name, "\nUnemployment Rate: ", round(avg_unemployment_rate, 2)))) + 
    expand_limits(x = world_map$long, y = world_map$lat) +
    scale_fill_continuous(name = paste(year, "Unemployment Rate")) +
    theme(axis.title.x = element_blank(), axis.text.x = element_blank(),
          axis.ticks.x = element_blank(), axis.title.y = element_blank(),
          axis.text.y = element_blank(), axis.ticks.y = element_blank(),
          panel.background = element_rect(fill = "white", color = "darkgray"),
          aspect.ratio = 3.1 / 5, legend.key.size = unit(8, "mm"),
          legend.text = element_text(size = 6), legend.title = element_text(size = 10)) +
    ggtitle(paste("Unemployment rate by country in", year, "divided by tropic")) +
    geom_hline(yintercept = 23.43612, color = "black") + # Tropic of Cancer
    geom_hline(yintercept = -23.43612, color = "black") + # Tropic of Capricorn
    annotate("text", x = -159, y = 23.43612 - 4, label = "Tropic of Cancer", color = "black", size = 2) +
    annotate("text", x = -154, y = -23.43612 - 4, label = "Tropic of Capricorn", color = "black", size = 2)
  
  girafe(ggobj = gg)
}

#chart3_age

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

