#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  fluidRow(
    column(12, 
           titlePanel("MTCARS"),
           textOutput("t1"),
           h3("Column Names"),
           textOutput("t2"),
           h3("Plot function selector"),
           textOutput("tpf"),
           h3("Linear Model"),
           textOutput("tlm"),
           hr()
           )
    
  ),
  
  fluidRow(
    column(12,
           
           
           
           
           # Sidebar with a slider input for number of bins 
           sidebarLayout(
             sidebarPanel(
               h4("Plot function selector"),
               checkboxInput("Plot Function",
                             "Checked for hist(), unckeck for plot()",
                             FALSE),
               h4("Linear Model"),
               textInput("formula", "Formula", "mpg ~ ."),
               actionButton("fitme", "Plot Model"),
               actionButton("summaryFit", "Get Coeficients")
               
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotOutput("distPlot"),
               plotOutput("linearModel"),
               tableOutput("summarySpace")
             )
           )
           
           )
    
  )
  
))
