library(shiny)

source("chart2_tropics.R")
source("chart3_age.R")

# Define a range of years for selection
years <- 2014:2024

ui <- navbarPage("Global Unemployment Trends",
                 
                 tabPanel("Introduction",
                          mainPanel(
                            fluidRow(
                              align = "center",
                              "This is an introduction"
                            ), width = 12
                          )
                 ),
                 
                 tabPanel("Impact of Covid 19",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Ageism in US with Unemployment Rate"),
                              p("This chart shows the average unemployment rate for different age categories in the United States. Select a year to see the data."),
                              selectInput(inputId = "year_ageism",
                                          label = "Select a Year:",
                                          choices = years,
                                          selected = tail(years, 1)
                              )
                            ),
                            mainPanel(
                              plotOutput(outputId = "ageplot")
                            )
                          )
                 ),
                 
                 tabPanel("Ageism in US",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Ageism in US with Unemployment Rate"),
                              p("This chart shows the average unemployment rate for different age categories in the United States. Select a year to see the data."),
                              selectInput(inputId = "year_ageism",
                                          label = "Select a Year:",
                                          choices = years,
                                          selected = tail(years, 1)
                              )
                            ),
                            mainPanel(
                              plotOutput(outputId = "ageplot")
                            )
                          )
                 ),
                 
                 tabPanel("Global Unemployment Map",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Global Unemployment Rates"),
                              p("This map shows the average unemployment rate by country. Select a year to see the data."),
                              sliderInput(inputId = "year_map",
                                          label = "Select a Year:",
                                          min = min(years),
                                          max = max(years),
                                          value = tail(years, 1),
                                          step = 1, 
                                          animate = TRUE) # Set animate = TRUE for continuous slider
                            ),
                            mainPanel(
                              girafeOutput(outputId = "unemployment_map")
                            )
                          )
                 ),
                 
                 tabPanel("Conclusion",
                          mainPanel(
                            fluidRow(
                              align = "center",
                              "This is a conclusion"
                            ), width = 12
                          )
                 ),
                 
                 includeCSS("www/styles.css") # Include the custom CSS file
)
