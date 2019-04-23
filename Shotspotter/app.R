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


#We have decided to use the data from Wilmington, North Carolina, 


# Define UI for application that draws a animated plot


ui <- navbarPage(
    "Shots spotted in Wilmington, NC",
   
   
    
  # The titles for our plot, tabs and plot are all included here
  
   tabPanel("Home",
            fluidPage(
   
    titlePanel("Shots spotted in Wilmington, NC"),
      
      mainPanel(
          "April Chen & Neil Khurana",

         imageOutput("output")
      )
   )
  )
)

# Define server logic required to draw an animated plot

server <- function(input, output) {
   
   output$output <- renderImage({
     
     
     #the outfile type is defined
     
      
      list(src = "outfile.gif",
           contentType = 'image/gif'
           # width = 400,
           # height = 300,
           # alt = "This is alternate text"
      )}, deleteFile = FALSE)}
      

# Run the application


shinyApp(ui = ui, server = server)

