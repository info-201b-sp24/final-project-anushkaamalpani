
library(tidyverse) 
library(readr)
library(ggplot2)
library(dplyr)
#load data 
dataframe <- read.csv("https://raw.githubusercontent.com/info-201b-sp24/exploratory-analysis-anushkaamalpani/main/data.csv")

#filter Canada Rows
q_1_canada <- dataframe[175:180,]

#group by sex and average the ages for each year going to be used
q_1_final <- q_1_canada %>%
  group_by(sex) %>%
  summarise(
    avg_unemployment_rate_2017 = mean(X2017, na.rm = TRUE),
    avg_unemployment_rate_2018 = mean(X2018, na.rm = TRUE),
    avg_unemployment_rate_2019 = mean(X2019, na.rm = TRUE),
    avg_unemployment_rate_2020 = mean(X2020, na.rm = TRUE),
    avg_unemployment_rate_2021 = mean(X2021, na.rm = TRUE),
    avg_unemployment_rate_2022 = mean(X2022, na.rm = TRUE)
  )

#create the data frame for graph
data <- data.frame(
  sex = c("Female", "Male"),
  avg_unemployment_rate_2017 = c(6.947000, 8.539333),
  avg_unemployment_rate_2018 = c(6.612000, 7.760667),  
  avg_unemployment_rate_2019 = c(6.400333, 7.758000),
  avg_unemployment_rate_2020 = c(12.28867, 12.89200),
  avg_unemployment_rate_2021 = c(8.795333, 9.627667),
  avg_unemployment_rate_2022 = c(6.195667, 7.060667)
)

# convert data into long format for ggplot
data_long <- pivot_longer(data, 
                          cols = starts_with("avg_unemployment_rate"),
                          names_to = "year", 
                          names_prefix = "avg_unemployment_rate_",
                          values_to = "avg_unemployment_rate")

#create line graph
graph <- ggplot(data_long, aes(x = year, y = avg_unemployment_rate, color = sex, group = sex)) +
  geom_line() +
  labs(x = "Year", y = "Average Unemployment Rate", title = "Average Unemployment Rate by Sex In Canada") +
  theme_minimal() +
  scale_x_discrete(labels = c("2017", "2018", "2019", "2020", "2021", "2022")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

