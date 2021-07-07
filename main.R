library(shiny)

library(ggplot2)
library(tidyverse)
library(rgeos)
library(rgdal)
library(maptools)

source("ui.R")
source("server.R")

shinyApp(server = server, ui = ui)