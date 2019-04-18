#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggthemes)
library(sf)
library(gganimate)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      shot_locations <- st_as_sf(wilmington,
                                 coords = c("Longitude", "Latitude"), 
                                 crs = 4326) 
      
      ggplot(data = shapes) + 
        geom_sf() + 
        geom_sf(data = shot_locations) +
        coord_sf(crs = st_crs(4326)) + 
        transition_states(week, transition_length=1, state_length = 30)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

