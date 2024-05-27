library(shiny)
library(plotly)

source("chart2_tropics.R")
source("chart3_age.R")
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
