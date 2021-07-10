

server <- function(input, output, session) {
  
  # Interactive covid map
  output$ukMapPlot <- renderLeaflet({
    
    data_to_use <- covid_map_data %>%
      filter(date == input$dateSlider)
    
    data_column <- c("Daily Cases", "Cumulative Deaths")[as.numeric(input$dataRadioType)]
    
    covid_map <- tm_shape(data_to_use) +
      tm_polygons(data_column, id="name", palette="Reds")
    tmap_leaflet(covid_map)
  })
  
  output$authorityScatterPlot <- renderPlot({
    
    if (input$authorityDataRadioType == "1") {
      y_data <- covid_income_data$cumulativeCases
      y_lab <- "Cumulative Cases"
    } else {
      y_data <- covid_income_data$cumulativeDeaths
      y_lab <- "Cumulative Deaths"
    }
    
    ggplot(data=covid_income_data, 
           aes(x=net_income,
               y=y_data,
               colour=y_data)) +
      geom_point(size=3) +
      scale_colour_gradient(name=y_lab, low="#F6BDC0", high="#CD0002") +
      ggtitle(paste("Scatter plot of Average Net Income of Local Authorities and their", y_lab)) +
      xlab("Average Net Income") +
      ylab(y_lab) +
      theme_bw()
  })
  
  output$authorityLinePlot <- renderPlot({
    
    data_to_use <- covid_data %>%
      filter(name == input$authoritySelect)
    
    ggplot(data=data_to_use,
           aes(x=date,
               y=dailyCases,
               colour=dailyCases)) +
      geom_point() +
      geom_line() +
      scale_colour_gradient(name="Daily Cases", low="#F6BDC0", high="#CD0002") +
      ggtitle(paste("Line chart of Daily Cases in", input$authoritySelect)) +
      xlab("Date") +
      ylab("Daily Cases") +
      scale_x_date(date_labels = "%Y-%m-%d") +
      theme_bw()
  })
  
  output$regionPlot <- renderPlot({
  
    data_to_use <- region_covid_data %>%
      filter(name == input$regionSelect)
    
    if (input$regionDataRadioType == "1") {
      y_data <- data_to_use$cumulativeCases
      y_lab <- "Cumulative Cases"
    } else {
      y_data <- data_to_use$cumulativeDeaths
      y_lab <- "Cumulative Deaths"
    }
      
    ggplot(data=data_to_use,
           aes(x=date,
               y=y_data,
               colour=y_data)) +
      geom_line(size=2) +
      scale_colour_gradient(name=y_lab, low="#F6BDC0", high="#CD0002", labels=comma) +
      ggtitle(paste("Line chart of", y_lab,"in",input$regionSelect)) +
      xlab("Date") +
      ylab(y_lab) +
      scale_x_date(date_labels = "%Y-%m-%d") +
      scale_y_continuous(labels = comma) + 
      theme_bw()
  })
}