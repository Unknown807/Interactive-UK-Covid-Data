
ui <- navbarPage(title="UK Covid Data Visualised",
  tabPanel(title="Maps",
           tags$head(includeCSS("styles\\styles.css")),
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Options"),
                      radioButtons("dataRadioType",
                                   h5("Data"),
                                   choices = list("Daily Cases"=1,
                                                  "Cumulative Deaths"=2),
                                   selected=1),
                      
                      sliderInput("dateSlider",
                                  h5("Date"),
                                  min=min_date,
                                  max=max_date,
                                  value=max_date,
                                  ticks=FALSE,
                                  timeFormat="%Y-%m-%d")
                    ),
             ),
             column(9,
                    leafletOutput("ukMapPlot", height="600px")
             )
           ),
  ),
  tabPanel(title="Other Option 1"
  ),
  tabPanel(title="Other Option 2",
  ),
  tabPanel(title="About",
  )
)