
tmap_options(check.and.fix = TRUE)
tmap_mode("view")

shp <- st_read("resources\\Local_Authority_Districts_(December_2020)_UK_BUC.shp", stringsAsFactors=FALSE)
shp <- rename(shp, name=LAD20NM)

data <- read.csv("resources\\authorities.csv") %>%
  filter(date == max(date)) %>%
  mutate(dailyCases = replace_na(dailyCases, 0)) %>%
  select(!X)

shp <- inner_join(shp, data)

server <- function(input, output, session) {
  
  output$ukMapPlot <- renderLeaflet({
    map1 <- tm_shape(shp) +
      tm_polygons("dailyCases", id="name", palette="Reds")
    tmap_leaflet(map1)
  })
  
}

# Reading test data and plotting it onto shape file ----
# 
# library(ggplot2)
# library(tidyverse)
# library(rgeos)
# library(rgdal)
# library(maptools)
# 
# shp <- readOGR("resources/Local_Authority_Districts_(December_2020)_UK_BUC.shp")
# shp <- fortify(shp, region="LAD20CD")
# 
# live_births <- read.csv("resources/parentscountryofbirth - Sheet1.csv")
# 
# shp <- merge(shp, live_births, by.x="id", by.y="Code", all.x=TRUE)
# shp <- arrange(shp, order)
# 
# p <- ggplot(data = shp, aes(x = long, y = lat,
#                             group = group, fill = Perc)) +
#   geom_polygon() + coord_equal() + theme_void() +
#   ggtitle('Percentage of births where one of both parents were born outside the UK',
#           subtitle = 'England and Wales, 2018')
# 
# shp$Perc <- as.numeric(shp$Perc)
# map1 <- ggplot(shp, aes(x=long, y=lat, group=group)) +
#   geom_polygon(aes(fill=Perc), color="black") +
#   coord_equal() + theme_void() +
#   geom_tile(aes(fill=Perc)) +
#   scale_fill_continuous(limits=c(0, 100), breaks=seq(0, 90, by=10))
# 
# map1
