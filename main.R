library(shiny)
library(leaflet)
library(tidyverse)
library(sf)
library(tmap)
library(tmaptools)

tmap_options(check.and.fix = TRUE)
tmap_mode("view")

shp <- st_read("resources\\Local_Authority_Districts_(December_2020)_UK_BUC.shp", stringsAsFactors=FALSE) %>%
  rename(name=LAD20NM)

data <- read.csv("resources\\authorities.csv")


int_map_data <- inner_join(shp, data) %>%
  select(-c(OBJECTID, LAD20CD,
            code, dailyDeaths,
            X, LAD20NMW)) %>%
  rename("Daily Cases"=dailyCases,
         "Cumulative Deaths"=cumulativeDeaths)

max_date = as.Date(max(int_map_data$date))
min_date = as.Date(min(int_map_data$date))

# %>%
#   filter(date == max(date)) %>%
#   mutate(dailyCases = replace_na(dailyCases, 0)) %>%
#   select(!X)

source("ui.R")
source("server.R")

shinyApp(server = server, ui = ui)