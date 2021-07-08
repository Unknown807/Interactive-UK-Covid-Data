

server <- function(input, output, session) {
  
  output$ukMapPlot <- renderLeaflet({
    
    data_to_use <- covid_map_data %>%
      filter(date == input$dateSlider)
    
    data_column <- c("Daily Cases", "Cumulative Deaths")[as.numeric(input$dataRadioType)]
    
    covid_map <- tm_shape(data_to_use) +
      tm_polygons(data_column, id="name", palette="Reds")
    tmap_leaflet(covid_map)
  })
  
  output$authorityPlot <- renderPlot({
    
    x_data <- covid_income_data$net_income
    
    if (input$authorityDataRadioType == "1") {
      y_data <- covid_income_data$cumulativeCases
      y_lab <- "Cumulative Cases"
    } else {
      y_data <- covid_income_data$cumulativeDeaths
      y_lab <- "Cumulative Deaths"
    }
    
    ggplot(data=covid_income_data, 
           aes(y=y_data,
               x=x_data,
               colour=y_data)) +
      geom_point(size=3) +
      scale_colour_gradient(name=y_lab, low="#F6BDC0", high="#CD0002") +
      ggtitle(paste("Scatter plot of Average Net Income of Local Authorities and their", y_lab)) +
      xlab("Average Net Income") +
      ylab(y_lab) +
      theme_bw()
  })
  
  # output$regionPlot <- renderPlot({
  #   ggplot(data=covid_income_data,
  #          aes(y=cumulativeCases,
  #              x=net_income,
  #              colour=cumulativeCases)) +
  #     geom_point(size=3) +
  #     scale_colour_gradient(name="Cumulative Cases", low="#F6BDC0", high="#CD0002") +
  #     ggtitle("Scatter plot of Average Net Income of Local Authorities and their Cumulative Covid Cases") +
  #     xlab("Average Net Income") +
  #     ylab("Cumulative Cases") +
  #     theme_bw()
  # })
  
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
