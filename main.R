library(shiny)
library(leaflet)

library(ggplot2)
library(tidyverse)
library(sf)
library(tmap)
library(tmaptools)

tmap_options(check.and.fix = TRUE)
tmap_mode("view")

# Get net annual income for MSOA in England and Wales and aggregate to get mean for local authorities
income_data <- read.csv("resources\\netannualincome2018.csv") %>%
  mutate(Net.annual.income = replace_na(
    Net.annual.income, mean(
      c(Upper.confidence.limit, Lower.confidence.limit)
      )
    ))

income_data <- rename(income_data, 
                      name=Local.authority.name,
                      net_income=Net.annual.income)

income_data <- income_data %>%
  mutate(net_income=as.numeric(gsub(",", "", net_income)))

income_data <- aggregate(net_income ~ name,
                         data=income_data,
                         function(x) { round(mean(x)) } )

# Get covid data for regions
region_covid_data <- read.csv("resources\\regions.csv") %>%
  select(date, name, cumulativeCases, cumulativeDeaths) %>%
  mutate(date=as.Date(date))

# Reading shape file, covid data and joining the data frames
shp <- st_read("resources\\Local_Authority_Districts_(December_2020)_UK_BUC.shp", stringsAsFactors=FALSE) %>%
  rename(name=LAD20NM)

covid_data <- read.csv("resources\\authorities.csv") %>%
  select(-c(X, code))

covid_map_data <- inner_join(shp, covid_data) %>%
  select(-c(OBJECTID, LAD20CD,
            dailyDeaths, LAD20NMW)) %>%
  rename("Daily Cases"=dailyCases,
         "Cumulative Deaths"=cumulativeDeaths)

# Join the income_data onto the covid data for local authorities
covid_income_data <- inner_join(
  aggregate(. ~ name,
            data=covid_data,
            max),
  income_data) %>%
  select(-c(dailyCases, dailyDeaths)) %>%
  mutate(cumulativeCases=as.numeric(cumulativeCases),
         cumulativeDeaths=as.numeric(cumulativeDeaths))

# Get dates for the dataSlider's range
max_date = as.Date(max(covid_map_data$date))
min_date = as.Date(min(covid_map_data$date))

# Run shiny application
source("ui.R")
source("server.R")

shinyApp(server = server, ui = ui)