library(shiny)
library(threejs)
library(dplyr)

source("preprocess_data.R")

glob_ter <- preprocess.gtd.data() %>% filter(iyear >= 2010)


ui <- fluidPage(
   fluidRow(
      column(12, 
        globeOutput("globe", width = "100%", height = "800px")
      )
   )
)

server <- function(input, output) {
   output$globe <- renderGlobe({
     globejs(
       lat = glob_ter$latitude,
       long = glob_ter$longitude,
       value = glob_ter$nkill,
       atmosphere = TRUE
     )
   })
}

shinyApp(ui = ui, server = server)