library(shiny)
library(plotly)
library(ggiraph)

source("chart2_tropics.R")
source("chart3_age.R")

server <- function(input, output) {
  
  ageism_plot <- reactive({
    create_ageism_plot(input$year_ageism)
  })
  
  output$ageplot <- renderPlot({
    ageism_plot()
  })
  
  unemployment_plot <- reactive({
    create_unemployment_plot(input$year_map)
  })
  
  output$unemployment_map <- renderGirafe({
    unemployment_plot()
  })
}
