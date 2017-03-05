
library(shiny)
library(plotly)
# c = 5#input$purchasing
# c_t = 100#input$order
# D = 520#input$demand
# h = 0.2#input$holding
# c_e = h*c
# c_s = 1#input$shortage
# b = 5#input$backorder
# robust = 1.3#input$robust

shinyUI(navbarPage ("EOQ with Planned Backorders",
                    tabPanel("EOQ plot",
                             fluidPage(
                               sidebarLayout(
                                 sidebarPanel(
                                   numericInput(
                                     "demand",
                                     label = h3("Annual Demand:  "),
                                     value = 100
                                   ),
                                   numericInput(
                                     "order",
                                     label = h3("Cost per Order:  "),
                                     value = 50
                                   ),
                                   numericInput(
                                     "holding",
                                     label = h3("Holding Ratio (%):"),
                                     value = 20
                                   ),
                                   numericInput(
                                     "shortage",
                                     label = h3("Shortage Cost:  "),
                                     value = 5
                                   ),
                                   numericInput(
                                     "purchasing",
                                     label = h3("Purchase Cost:  "),
                                     value = .33
                                   ),
                                   sliderInput("robust",
                                               label = h3 ("Robustness"),
                                               min = 0.1,
                                               max = 5,
                                               value = 1
                                   )
                                 ),
                                 mainPanel(plotlyOutput ("cost_plot"
                                 ),
                                 htmlOutput("ex1"
                                 )
                                 )
                               )
                             )
                    )
)
)
