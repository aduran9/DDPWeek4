#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)
library(lubridate)
library(scales)
library(ggplot2)


shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        datainfo <- read.csv('Traffic.csv')
        datainfo$TrafDate <- as.Date(datainfo$TrafDate, format = "%Y-%m-%d")
        datainfo_date <- datainfo %>% filter(TrafDate >= input$x[1] & TrafDate <=input$x[2])
        datainfo_date <- filter(datainfo_date, Proveedor %in% input$Provider)
        
        p <- ggplot(datainfo_date, 
                    aes_string(x = "TrafDate", 
                        y = input$y))+
             geom_point()+
             labs(x = "Date Lapse",
                  y = "Traffic Feature Units",
                  title = "Internet Traffic In The Pandemic Year")+
             theme(axis.text.x = element_text(angle=90, hjust = 1))

        datainfo <- read.csv('Traffic.csv')
        
        if (input$smooth)
            p <- p + geom_smooth()
        
        print(p)
    })

})
