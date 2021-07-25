#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)
library(dplyr)
library(scales)

datainfo <- read.csv('Traffic.csv')

min_date <- min(datainfo$TrafDate)
max_date <- max(datainfo$TrafDate)

Provider <- datainfo$Proveedor

cols_tags = c("RushHour",
              "TrafIntNal",
              "TrafNAPCo",
              "TrafAcuer",
              "TrafLocal",
              "TrafTotal"
)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Telecommunications's features for Internet Traffic Report in Colombia"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(

            helpText("Select the 'Traffic Feature' to study: "),
            
            selectInput(inputId = "y", 
                        label = "Y-Vertical", 
                        choices =  names(datainfo),
                        selected = names(datainfo)[[5]]
                        ),
            dateRangeInput(inputId = "x",
                           label = " Select dates: ",
                           start = "2020-06-01",
                           end = "2020-07-01",
                           startview = "year",
                           min = as.Date(min_date), 
                           max = as.Date(max_date)
                        ),
            
            helpText("Select one provider to Plot: "),
            
            selectInput(inputId = "Provider", 
                        label = "Telecomms Provider", 
                        choices =  datainfo$Proveedor,
                        selected = "CLARO "
                        ),

            checkboxInput("smooth", "Smooth Data"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            h4("Traffic behaviour of the features in the TimeLapse given"),
            h5("- Provider: Colombia's Telecommunications provider-PRST"),
            h5("- RushHour: maximun peak in one hour continuos (Hour:Minute)"),
            h5("- TrafIntNal: maximun data's peak in RushHour (GigaBytes)"),
            h5("- TrafNAPCo: Traffic to any NAP base in Colombia (GigaBytes)"),
            h5("- TrafAcuer: Traffic between nationals PRST (GigaBytes"),
            h5("- TrafLocal: Traffic of national Content Delivery (GigaBytes"),
            h5("- TrafTotal: Traffic trought the national's NAP (GigaBytes")
        )
    )
))
