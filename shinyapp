library(shiny)
library(tidyverse)
library(leafpop)
library(sf)
library(mapview)


ui <- fluidPage(
  titlePanel("Performance Of Glass Recycling Sites in Leeds (in kg)"),
  mapviewOutput("leeds_bins")
)


server <- function(input, output) {
  output$leeds_bins <- renderMapview({
    locations_bins <- leeds_map_info_2019 %>%
      filter(!is.na(longitude) & !is.na(latitude)) %>%
      st_as_sf(coords = c("longitude", "latitude"), 
               crs = 4326)
    
    mapview(locations_bins,
            zcol = "recycled_per_site",
            at = seq(160, 400000, 50000),
            layer.name = "Glass Recycling Sites",
            map.types = "Stamen.TonerLite",
            cex = "recycled_per_site",
            alpha = 0,
            legend = FALSE,
            label = "site_name")
  })
}

shinyApp(ui = ui, server = server)
