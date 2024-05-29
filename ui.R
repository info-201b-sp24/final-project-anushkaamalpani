library(shiny)

source("charts.R")

# Define a range of years for selection
years <- 2014:2024

ui <- navbarPage("Global Unemployment Trends",
                 
                 tabPanel("Introduction",
                          mainPanel(
                            fluidRow(
                              h2("Introduction"),
                              p("Unemployment is a situation wherein a person, who is actively looking for a job, is unable to find work. The unemployment rate is defined as the number of people without work, represented as a percentage of the labor force. It serves as an indicator of the health of the economy."), tags$img(src = "https://laboriq.co/hs-fs/hubfs/Shutterstock_336372527.png?width=600&height=397&name=Shutterstock_336372527.png", alt = "Unemployment", width = "300px", style = "display: block; margin-left: auto; margin-right: auto;"), 
                              p("Analyzing unemployment rates throughout the years in different countries is crucial for understanding economic fluctuations during different periods. This analysis aims to address several key questions:"),
                              tags$ul(
                                tags$li("To what extent was the employment rate between sexes affected by Covid-19 in multiple countries?"),
                                tags$li("Is there a relationship between tropic zones and unemployment rates?"),
                                tags$li("How does the unemployment rate of different age groups differ between 2014 to 2024 in the United States?")
                              ),
                              p("By examining these factors, we aim to identify disparities and trends in workforce participation across various regions and periods. This understanding is essential for creating more equitable employment opportunities and addressing broader social issues."),
                              
                              h3("Dataset Information"),
                              p("This data is sourced from Kaggle – Global Unemployment dataset and was tabulated from the data collected by the ILO. It is updated and posted on Kaggle by Sazidul Islam to measure changes in employment across 189 countries/regions over 11 years."),
                              
                              h3("Limitations/Problems"),
                              p("There are a few limitations that we should consider when working with this data set:"),
                              tags$ul(
                                tags$li("It does not provide a holistic view of unemployment rates, as all data is numeric with no description of how exactly this data was collected or what factors were considered during data collection."),
                                tags$li("The data collected is the mean calculated over the course of a year rather than collecting exact data per month. This can cause problems with exact data values and reliability."),
                                tags$li("Fluctuations within unemployment rates over a shorter period are not visible in this dataset. Relying entirely on yearly averages can hide important trends and variations that occur throughout the year."),
                                tags$li("Jobs with seasonal fluctuations, weather cycles, and economic cycles can affect employment rates on a monthly basis. These fluctuations are not shown and are ignored in this dataset, making the data less specific."),
                                tags$li("The process of copying data from the ILO LFS database and then sourcing it to present on Kaggle can lead to loss of detail or granularity in the dataset. There may have been reformatting of the data by the author of the dataset which may have unintentionally led to loss of important data.")
                              )
                            ), width = 12
                          )
                 ),
                 
                 tabPanel("Impact of Covid",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Unemployment Rates between Male and Females in Different Countries"),
                              selectInput(inputId = "country",
                                          label = "Select a country:",
                                          choices = c("Canada", "United States", "Brazil", "India"),
                                          selected = tail(years, 1)
                              ),
                              p("This chart analyzes the unemployment rate between males and females in 4 different countries over the years of 2017 to 2022. These countries include Canada, The United States, Brazil and India. We chose a graph with 2 lines to compare the male and female trends because it is visually easier to compare the rates. Users are able to view the rates in different countries by using the dropdown menu. ")),
                            mainPanel(
                              plotlyOutput(outputId = "covidplot")
                            )
                          )
                 ),
                 
                 tabPanel("Global Unemployment Map",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Global Unemployment Rates"),
                              sliderInput(inputId = "year_map",
                                          label = "Select a Year:",
                                          min = min(years),
                                          max = max(years),
                                          value = tail(years, 1),
                                          step = 1, 
                                          animate = TRUE),
                            p("From our second chart, we chose to analyze the unemployment rates across all countries and divide up the countries by tropic zones. We chose to display this information on a map as that would better visualise how the unemployment rate differs by tropic. The two horizontal lines depict the tropic of Cancer and Capricorn. A darker colour indicates a lower unemployment rate while a lighter colour indicates a higher unemployment rate, and a green or grey colour indicates that there’s no data.")
                            ),
                            mainPanel(
                              girafeOutput(outputId = "unemployment_map")
                            )
                          )
                 ),
                 
                 tabPanel("Ageism in US",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Ageism in US with Unemployment Rate"),
                              selectInput(inputId = "year_ageism",
                                          label = "Select a Year:",
                                          choices = years,
                                          selected = tail(years, 1)
                              ),
                              p("The chart compares the average unemployment rate among the age categories of Children (less than 15 years), Youth (15 years to 24 years), and Adults (25+ years) in the US over a span of 11 years. Users can get an output of the unemployment rate for each year by adjusting their input in the dropdown widget")
                            ),
                            mainPanel(
                              plotlyOutput(outputId = "ageplot")
                            )
                          )
                 ),
                 
                 tabPanel("Conclusion",
                          mainPanel(
                            fluidRow(
                              h2("Conclusion"),
                              p("After analyzing this data set, we have 3 major takeaways:"),
                              tags$ul(
                                tags$li("After analyzing this data set, we have 3 major takeaways. From our first chart, we were able to see that the unemployment rate for both male and females went through similar fluctuations overtime even though the male unemployment rate was always higher than the female. The biggest spike in the unemployment rate across each country analyzed, (Canada, United States, Brazil and India) is over the years of 2019-2021 during the COVID-19 pandemic. These findings have important implications for our economy. The significant rise in unemployment during the COVID-19 pandemic highlights the labor market to global disruptions. This chunk of high unemployment may have long-term effects on economic stability and growth. Additionally, being able to understand the impacts on male and female employment can guide more equitable economic recovery strategies in the future"),
                                tags$li("From our second chart, we can see that the highest unemployment rates are located in South Africa, North Africa, and Eastern Europe. More specifically, some of the highest unemployment rates are located close to where the tropic lines are, at 23.43612° North and South but only in the continents of Africa and Europe. These findings suggest that while geographic and climatic factors might influence unemployment rates, it is not a strong relationship as otherwise the trend would be visible in the Americas and Asia. Regardless, regions near the tropic lines may face challenges that contribute to higher unemployment, such as economic instability, or limited access to resources. Understanding these disparities is crucial for developing targeted economic policies. 
"),
                                tags$li("Lastly for our third chart we compared the average unemployment rate among the age categories of Children (less than 15 years), Youth (15 years to 24 years), and Adults (25+ years). Through our analysis, It is evident that the youth face the highest unemployment, followed by 'Children' and 'Adults,' it suggests that young people entering the job market out of college or even high school face the most challenges, whereas older adults have relatively stable employment. The impact of COVID-19 is also evident through this analysis where we see the unemployment rates across all age categories are highest in 2020. As time passes, the charts also show a decreasing unemployment rate for all age categories. This can help policymakers identify and design economic strategies favoring their employment. Over here in the US, they can introduce policies that focus on job training programs or educational initiatives for young people. This graph also gives us insight that children under the age of 15 facing unemployment may not be in school studying. This could indicate issues such as child labor or lack of access to education, which brings out the issue of children not receiving proper education and being part of the labor force.")
                              )
                            ), width = 12
                          )
                 ),
                 
                 includeCSS("www/styles.css")
)