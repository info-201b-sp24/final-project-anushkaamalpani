library(tidyverse) # This includes ggplot2, dplyr, tidyr, readr, and others
library(readr)
library(sf)
library(maps)
library(dplyr)
library(ggiraph)

# Import dataset
global_unemployment_data <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/exploratory-analysis-anushkaamalpani/main/data.csv")

create_unemployment_plot <- function(year) {
  
  world_map <- map_data("world")
  
  # Averaging unemployment rate for the specified year
  avg_unemployment_rate_col <- paste0("X", year)
  q2_year <- global_unemployment_data %>%
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