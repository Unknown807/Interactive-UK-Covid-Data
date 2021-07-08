
ui <- navbarPage(title="UK Covid Data Visualised",
  tabPanel(title="Maps",
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Configurations"),
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
                    leafletOutput("ukMapPlot")
             )
           ),
  ),
  tabPanel(title="Comparisons",
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Configurations"),
                      radioButtons("authorityDataRadioType",
                                   h5("Authorities"),
                                   choices = list("Cumulative Cases"=1,
                                                  "Cumulative Deaths"=2),
                                   selected=1),
                      hr(),
                      radioButtons("regionDataRadioType",
                                  h5("Region Options"),
                                  choices = list("Cumulative Cases"=1,
                                                 "Cumulative Deaths"=2),
                                  selected=1),
                      selectInput("regionSelect",
                                  h5("Regions"),
                                  choices = list("England"=1, 
                                                 "Scotland"=2, 
                                                 "Wales"=3, 
                                                 "Northern Ireland"=4),
                                  selected=1)
                    )
             ),
             column(9,
                    fluidRow(
                      plotOutput("authorityPlot")
                    ),
                    fluidRow(
                      plotOutput("regionPlot")
                    )
                    
             )
           )
  ),
  tabPanel(title="Other Option 2",
  ),
  tabPanel(title="About",
  ),
  tags$head(includeCSS("styles\\styles.css"))
)