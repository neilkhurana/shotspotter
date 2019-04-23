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
library(gifski)
library(magick)
library(tigris)
library(lubridate)

wilmington <- read_csv("http://justicetechlab.org/wp-content/uploads/2018/05/Wilmington_ShotspotterCAD_calls.csv",
                       col_types = cols(
                         calltime = col_datetime(format = "%m/%d/%Y %H:%M:%S"),
                         street = col_character(),
                         crossroad1 = col_character(),
                         crossroad2 = col_character(),
                         geox = col_double(),
                         geoy = col_double(),
                         nature = col_character(),
                         `FIRST UNIT DISPATCHED` = col_character(),
                         `first Dispatch Time` = col_character(),
                         `first unit on the way` = col_character(),
                         `first unit there` = col_character(),
                         `last unit to leave the scene` = col_character(),
                         primeunit = col_character(),
                         reptaken = col_double(),
                         closecode = col_character(),
                         notes = col_character(),
                         timeclose = col_character(),
                         Latitude = col_double(),
                         Longitude = col_double()
                       )) %>%
  filter(Latitude, Longitude) %>%
  select(calltime, Latitude, Longitude) %>%
  mutate(week = floor_date(calltime, "week"))


shapes <- urban_areas(class = "sf") %>%
  filter(NAME10 == "Wilmington, NC") 

# Define UI for application that draws a histogram
ui <- navbarPage(
    "Shots spotted in Wilmington, NC",
   
   # Application title
   tabPanel("Home",
            fluidPage(
   
    titlePanel("Shots spotted in Wilmington, NC"),
      
      # Show a plot of the generated distribution
      mainPanel(
          "April Chen & Neil Khurana",

         plotOutput("distPlot")
      )
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
        transition_states(week, transition_length=1, state_length = 30) +
        labs(title = "Shots fired in Wilmington, NC by Week of: {closest_state}", source = 
               "ShotSpotter Data")
      
     })}

# Run the application 
shinyApp(ui = ui, server = server)

