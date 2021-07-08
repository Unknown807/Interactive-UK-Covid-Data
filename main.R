library(shiny)
library(leaflet)
library(tidyverse)
library(sf)
library(tmap)
library(tmaptools)

tmap_options(check.and.fix = TRUE)
tmap_mode("view")

# Get net annual income for MSOA in England and Wales and aggregate to get mean for the Local Authorities
income_data <- read.csv("resources\\netannualincome2018.csv") %>%
  mutate(Net.annual.income = replace_na(
    Net.annual.income, mean(
      c(Upper.confidence.limit, Lower.confidence.limit)
      )
    ))

income_data$Net.annual.income <- as.numeric(gsub(",", "", income_data$Net.annual.income))

income_data <- aggregate(Net.annual.income ~ Local.authority.name,
                         data=income_data,
                         function(x) { round(mean(x)) } )

# Get covid data for regions
region_covid_data <- read.csv("resources\\regions.csv") %>%
  select(date, name, cumulativeCases, cumulativeDeaths) %>%
  rename("Cumulative Cases"=cumulativeCases,
         "Cumulative Deaths"=cumulativeDeaths)

# Reading shape file, covid data and joining the data frames
shp <- st_read("resources\\Local_Authority_Districts_(December_2020)_UK_BUC.shp", stringsAsFactors=FALSE) %>%
  rename(name=LAD20NM)

covid_data <- read.csv("resources\\authorities.csv")

covid_map_data <- inner_join(shp, covid_data) %>%
  select(-c(OBJECTID, LAD20CD,
            code, dailyDeaths,
            X, LAD20NMW)) %>%
  rename("Daily Cases"=dailyCases,
         "Cumulative Deaths"=cumulativeDeaths)

# Get dates for the dataSlider's range
max_date = as.Date(max(covid_map_data$date))
min_date = as.Date(min(covid_map_data$date))

# Run shiny application
source("ui.R")
source("server.R")

shinyApp(server = server, ui = ui)