library(shiny)
library(tidyverse)
library(leafpop)
library(leaflet)
library(sf)
library(mapview)

ui <- fluidPage(
    titlePanel("Performance Of Glass Recycling Sites in Leeds from April 2019-2020 (in kg)"),
    mapviewOutput("leeds_bins")
)

server <- function(input, output) {
    output$leeds_bins <- renderLeaflet({
        
        leeds_map_info_2019 <- read.csv("./leeds_map_info_2019.csv", dec=".", header=TRUE)
        
        locations_bins <- leeds_map_info_2019 %>%
            filter(!is.na(longitude) & !is.na(latitude)) %>%
            st_as_sf(coords = c("longitude", "latitude"), 
                     crs = 4326)
        
        mapview(locations_bins,
                zcol = "recycled_per_site",
                at = seq(160, 400000, 50000),
                popup = popupTable(locations_bins,
                                   zcol = c("site_name", "recycled_per_site"),
                                   className = "mapview-popup", row.numbers = FALSE),
                layer.name = "Glass Recycling Sites (kg)",
                map.types = "Stamen.TonerLite",
                cex = "recycled_per_site",
                alpha = 0,
                legend = TRUE,
                label = "site_name")@map
        
        
    })
}

shinyApp(ui = ui, server = server)
