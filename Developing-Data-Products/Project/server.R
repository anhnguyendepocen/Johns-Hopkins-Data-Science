#server.R

# server.R
library(shiny)
library(httr)
library(caret)
library(ggplot2)
library(gridExtra)
library(ggthemes)
library(ggExtra)
library(dplyr)
library(lubridate)

setwd("C:/Users/Paul/Desktop/R/Applications/DDP")
myData <- read.csv("labor_data.csv", header=TRUE)
nightModelStl <- lm(NUMBER.EMPLOYEES.NEEDED ~ TOTAL.UNITS, data=myData)
nightInterceptStl <- summary(nightModelStl)$coefficients[1]
nightSlopeCasesStl <- summary(nightModelStl)$coefficients[2]

actual <- data.frame(myData$NUMBER.EMPLOYEES.NEEDED)
actual$TYPE <- 'Actual'
names(actual) <- c('Number.Night.Employees', 'Type')
inferred <- data.frame(myData$NUMBER.EMPLOYEES.ACTUAL)
inferred$TYPE <- 'Inferred'
names(inferred) <- c('Number.Night.Employees', 'Type')
forHist <- rbind(inferred, actual)

g <- ggplot(data=forHist, aes(Number.Night.Employees, fill=Type))

shinyServer(
  function(input, output) {
    
    prediction <- reactive({ 
      round(nightInterceptStl + input$Cases * nightSlopeCasesStl, 1) 
    })
    
    output$Predicted.Number <- renderText({ paste('Based on the number of units, there will be ', prediction(), 'employees needed today.')
    })
    
    output$plot1 <- renderPlot({
      g + geom_density(alpha=0.4) + 
        ggtitle(expression(atop('Employees Needed per Evening',
                                atop(italic('Based on a 10 hour day'), "")))) +
        theme(legend.position='none') + geom_vline(xintercept=prediction(), colour='red') +
        labs(x='Number of Shift Employees') + geom_rug(aes(colour=Type)) + 
        theme_pander()
    }, height=250)
    
    })
    
