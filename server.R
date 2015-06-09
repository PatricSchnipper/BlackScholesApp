library(shiny)
source("BlackScholesFormula.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$price <- renderText({ 
    paste("The price of the option is", 
          round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, ), 
                digits=4))
    })
     
    output$delta <- renderText({ 
     paste("Delta (dP/dS) =", 
           round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, 2), 
                 digits=4))
   })
    
    output$gamma <- renderText({ 
      paste("Gamma (dP/(dS*dS)) =", 
            round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, 3), 
                  digits=4))
    })
    
    output$vega <- renderText({ 
      paste("Vega (dP/dSigma) =", 
            round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, 4)/100, 
                  digits=4))
    })
    
    output$theta <- renderText({ 
      paste("theta (dP/dt) =", 
            round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, 5)/365, 
                  digits=4))
    })
    
    output$rho <- renderText({ 
      paste("Rho (dP/dr) =", 
            round(BlackScholesFormula(input$spot, input$timetomat, input$strike, input$r_f/100, , input$sigma/100, input$optionType, 6)/10000, 
                  digits=8))
    })
})
