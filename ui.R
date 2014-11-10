library(shiny)
library(shinyIncubator)
 
shinyUI(fluidPage(
  progressInit(),
  headerPanel("Feeds Word Cloud"),
  sidebarPanel(width = 5,
               selectInput("selection", "Choose a feed:", 
                           choices = books),
               actionButton("update", "Change"),
               hr(),
               sliderInput("freq", 
                           "Minimum Frequency:", 
                           min = 1,  max = 50, value = 15),
               sliderInput("max", 
                           "Maximum Number of Words:", 
                           min = 1,  max = 300,  value = 100)
  ),
  mainPanel(
    plotOutput("plot"), 
  )
))
