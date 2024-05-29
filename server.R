library(shiny)
library(plotly)
library(ggiraph)

source("charts.R")

server <- function(input, output) {
  
  ageism_plot <- reactive({
    create_ageism_plot(input$year_ageism)
  })
  
  output$ageplot <- renderPlotly({
    ggplotly({ageism_plot()})
  })
  
  covid_plot <- reactive({
    plot_unemployment_rate(input$country)
  })
  
  output$covidplot <- renderPlotly({
    ggplotly({covid_plot()})
  })
  
  unemployment_plot <- reactive({
    create_unemployment_plot(input$year_map)
  })
  
  output$unemployment_map <- renderGirafe({
    unemployment_plot()
  })
}
