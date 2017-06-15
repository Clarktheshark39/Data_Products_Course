#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# load city data
cities <- read.csv("cities.csv")
for (i in c(2, 6:9)) {cities[, i] <- as.character(cities[, i])}
cities <- cities %>% select(-X)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("paper"),
  navbarPage("World City Data - Location and Income Group",
                   tabPanel("Map",
                            fluidRow(column(12,
                              h4("How would you like to sort the Map data?"),
                              p("Use the below options to filter the cities of the world according to your chosen parameters. Once you have selected the filters you would like, press the 'Generate Map' button at the bottom of the filters."))),
                              sidebarPanel(
                                sliderInput("pop", "Population (1000s)",
                                                          min = min(cities$pop),
                                                          max = max(cities$pop),
                                                          value = c(min(cities$pop), max(cities$pop))),
                                checkboxGroupInput("inc", "Income Level",
                                                                 choices = c("Low income", "Lower middle income",
                                                                             "Upper middle income", "High income")),
                                checkboxGroupInput("region", "Region",
                                                                 choices = c("East Asia & Pacific",
                                                                             "Europe & Central Asia",
                                                                             "Latin America & Caribbean",
                                                                             "Middle East & North Africa",
                                                                             "North America",
                                                                             "South Asia",
                                                                             "Sub-Saharan Africa")),
                                sliderInput("lat", "Latitude",
                                                          min = min(cities$lat),
                                                          max = max(cities$lat),
                                                          value = c(min(cities$lat), max(cities$lat))),
                                sliderInput("lng", "Longitude",
                                                          min = min(cities$lng),
                                                          max = max(cities$lng),
                                                          value = c(min(cities$lng), max(cities$lng))),
                                actionButton("go", "Generate Map")),
                            mainPanel(leafletOutput("map"))),
                   tabPanel("Documentation",
                            mainPanel(
                              p("This Shiny app is part of the Coursera 'Developing Data Products' class:"),
                              a("Coursera", href = "https://www.coursera.org/learn/data-products/home/welcome", target = '_blank'),
                              br(),
                              br(),
                              p("Data for this map can be found at the below links:"),
                              a("Simple Maps", href = "http://simplemaps.com/data/world-cities", target = '_blank'),
                              br(),
                              a("World Bank", href = "http://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD", target = '_blank'),
                              br(),
                              br(),
                              p("The code for this app is available at the following link:"),
                              a("Github", href = "", target = '_blank'),
                              br(),
                              br(),
                              p("A related presentation to this app, also for this course project, can be found at the following link:"),
                              a("Presentation", href = "http://rpubs.com/Clarktheshark39/Data_Products_Presentation", target = '_blank')
                            ))
  )
  )
)

