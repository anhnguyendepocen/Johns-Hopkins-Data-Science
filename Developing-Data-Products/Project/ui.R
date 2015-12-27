#ui.r

library(shiny)

shinyUI(fluidPage(
  titlePanel("Labor Tool for Hourly Associates"),
  
  mainPanel(
    
    p('Save all files to one location, ui.R, server.R, and labor_data.csv. Then, type in "library(shiny)" into the R console. Finally,
      set the working directory to the location where you saved the files and type "runApp()"'),
    
    br(),
    
    fluidRow(
      splitLayout(
        sliderInput("Cases",
                    "NUMBER OF CASES:",
                    min=0,
                    max=30000,
                    value=13253))),
      
      h3(textOutput('Predicted.Number')),
      
      br(),
      
      plotOutput('plot1'),
      
      br(),
    
    p('This forecast is based on a linear regression model.')
    
    )
  ))
