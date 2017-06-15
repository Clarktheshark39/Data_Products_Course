#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  mod_cities <- eventReactive(input$go, {
    cities <- cities %>% filter(pop >= input$pop[1] & pop <= input$pop[2])
    if (length(input$inc) > 0){
      cities <- cities %>% subset(IncomeGroup == input$inc)
    } 
    if (length(input$region > 0)){
      cities <- cities %>% subset(Region == input$region)
    }
    cities <- cities %>% filter(lat >= input$lat[1] & lat <= input$lat[2])
    cities <- cities %>% filter(lng >= input$lng[1] & lng <= input$lng[2])
  })
   
  output$map <- renderLeaflet({
    mod_cities() %>%
      leaflet() %>%
      addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions(), popup = paste(mod_cities()$city, mod_cities()$country, sep = ", ")) %>%
      addCircles(weight = 1, radius = mod_cities()$pop/ 100)
  })
  
})
