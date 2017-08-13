#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(formula.tools)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  v <- reactiveValues(doFit = "mpg ~ .",getSummary = FALSE)

  observeEvent(input$fitme, {
      
    v$doFit <- input$formula
  })
  
  observeEvent(input$summaryFit, {
    
    v$getSummary <- input$summaryFit
    
  })
  
  output$distPlot <- renderPlot({
    
    
    checked <- input$`Plot Function`
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2] 
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    if (checked == FALSE)
      hist(mtcars$mpg)
    else
      plot(x=mtcars$mpg, y=mtcars$hp)
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$linearModel <- renderPlot({
      #fit <- lm(AirPassengers ~ )
        if (nchar(v$doFit) == 0)
            v$doFit = "mpg ~ ."
        fit <- lm(formula(v$doFit), data = mtcars)
        #summary(fit)
        par(mfrow = c(2, 2))
          plot(fit)
          
      
  })
  
  output$summarySpace <- renderTable({
      if (v$getSummary == TRUE){
        fit <- lm(formula(v$doFit), data = mtcars)
        summary(fit)$coef
      }
  })
  
  output$t1 <- renderText({"Based on the mtcars data, this app can be used only with the column names of this data."})
  output$t2 <- renderText({paste(colnames(mtcars), "/")})
  output$tpf <- renderText({"This selector changes between a hist() and a plot() function."})
  output$tlm <- renderText({"In the text box you can set a formula for the lm() function, using the columns of the data MTCARS. Pressing the button 'Plor Model' you will get the different plots of the fitted model
                 and pressing the 'Get Coefficients' button you will get the coefficients of the fitted model based on the formula in the text box"})
})
