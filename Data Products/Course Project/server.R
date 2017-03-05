

library(shiny)
library(dplyr)
library(plotly)

shinyServer(function(input, output) {
  
  output$cost_plot = renderPlotly({
    library(plotly)
    c = input$purchasing
    c_t = input$order
    D = input$demand
    h = input$holding
    c_e = h*c
    c_s = input$shortage
    robust = input$robust
    
    Q_star = sqrt( 2*c_t*D / c_e )
    Q_pbo = Q_star * sqrt( (c_s+c_e) / c_s )
    CR = c_s/(c_s+c_e)
    b_star = round((c_e*Q_pbo) / (c_s + c_e)) #b_star = Q_pbo*(1 - CR)
    T_star = D / Q_pbo
    
    Q = Q_pbo
    real_Q = robust*Q#input$robust*Q
    
    annual_purchase_cost = c*D
    annual_order_cost = c_t*(D/Q)
    annual_holding_cost = c_e*( (Q - b_star)^2 / 2*Q )
    annual_shortage_cost = c_s*( b_star^2 / 2*Q )
    
    TRC = annual_order_cost + annual_holding_cost + annual_shortage_cost
    TC = annual_purchase_cost + annual_order_cost + annual_holding_cost + annual_shortage_cost
    #actual_cost = c*D + c_t*(D/real_Q) + c_e*( (real_Q - b)^2 / 2*real_Q ) + c_s*(b^2 / 2*real_Q)
    
    Qty = seq(from=50, to=max(Q*1.75, D*1.2), by=1)
    DF = data.frame(Qty=Qty)
    
    backorder = function(c_e, Q, c_s) { c_e*Q / (c_s + c_e) }
    ordering = function(c_t, D, Q) { c_t*(D/Q) }
    holding = function(c_e, Q, b) { c_e*( (Q - b)^2 / 2*Q ) }
    shortage = function(c_s, b, Q) { c_s*(b^2 / 2*Q) }
    eoq_trc = function(c_t, c_e, D, Q) { c_t*(D/Q) + c_e*(Q/2) }
    
    too_much = Qty-D
    too_few = D-Qty
    
    DF = DF %>%
      mutate (Purchasing=D*c,
              Ordering=ordering(c_t, D, Qty),
              Excess=holding(c_e, too_much, b_star),
              Shortage=shortage(c_s, b_star, too_few),
              TRC_EOQ=eoq_trc(c_t, c_e, D, Qty)
      )
    
    DF$Shortage = ifelse(DF$Qty <= D, DF$Shortage, 0)
    DF$Excess = ifelse(DF$Qty >= D, DF$Excess, 0)
    DF$TRC_PBO=DF$Ordering+DF$Excess+DF$Shortage
    DF$TC=DF$Purchasing+DF$Ordering+DF$Excess+DF$Shortage
    
    
    plot_ly(DF,
            x=~Qty,
            y=~TRC_PBO,
            name="TRC w/ PBO",
            type = "scatter",
            mode="lines",
            line = list( width = 4)) %>%
      add_trace(y=~Ordering,
                name = "Ordering cost",
                line = list( width = 2,
                             dash = 'dash')) %>%
      add_trace(y=~Excess,
                name = "Excess Holding cost",
                line = list( width = 2,
                             dash = 'dash')) %>%
      add_trace(y=~Shortage,
                name = "Shortage Cost",
                line = list( width = 2,
                             dash = 'dash')) %>%
      add_trace(y=~TRC_EOQ,
                name = "TRC w/ EOQ",
                line = list( width = 2,
                             dash = 'dash')) %>%
      layout(title="EOQ with Planned Backorders",
             xaxis = list(title = "Quantity Ordered"),
             yaxis = list (title = "Cost")) 
    

  })
  
  output$ex1 = renderText({
    c = input$purchasing
    c_t = input$order
    D = input$demand
    h = input$holding
    c_e = h*c
    c_s = input$shortage
    robust = input$robust
    
    Q_star = sqrt(2*c_t*D / c_e)
    Q_pbo = Q_star * sqrt((c_s*c_e)/c_s)
    CR = c_s/(c_s+c_e)
    b_star = (c_e*Q_pbo) / (c_s + c_e)
    b_star = Q_pbo*(1 - CR)
    T_star = D / Q_pbo
    
    Q = Q_pbo
    real_Q = robust*Q
    
    annual_purchase_cost = c*D
    annual_order_cost = c_t*(D/Q)
    annual_holding_cost = c_e*( (Q - b_star)^2 / 2*Q )
    annual_shortage_cost = c_s*(b_star^2 / 2*Q)
    
    TRC = annual_order_cost + annual_holding_cost + annual_shortage_cost
    TC = annual_purchase_cost + annual_order_cost + annual_holding_cost + annual_shortage_cost
    
    str0 = paste0('PUBLISHED ON MARCH 6, 2017 by PAUL WASHBURN')
    str1 = paste0('Optimal Qty w/ Planned Backorder = ', round(Q_pbo))
    str2 = paste0('Regular EOQ Qty = ', round(Q_star))
    str3 = paste0('Critical Ratio = ', round(CR, 2))
    str4 = paste0('Optimal Backorder Amount = ', round(b_star))
    str5 = paste0('Optimal Time b/n Orders = ', round(T_star, 2))
    str6 = paste0('Total Relevant Cost w/ Planned Backorder = ', round(TRC, 2))
    str7 = paste0('Total Cost w/ Planned Backorder = ', round(TC, 2))
    
 
    
    paste(str0, str1, str2, str3, str4, str5, str6, str7, sep = '<br/><br/>')
  })
  
})
