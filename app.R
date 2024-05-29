library(shiny)
library(plotly)
source("charts.R")
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
