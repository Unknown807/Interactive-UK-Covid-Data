
ui <- navbarPage(title="UK Covid Data Visualised",
  tabPanel(title="Maps",
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Options"),
                      radioButtons("dataRadioType",
                                   h5("Data"),
                                   choices = list("Daily Cases"=1,
                                                  "Daily Deaths"=2),
                                   selected=1),
                      sliderInput("dateSlider",
                                  h5("Date"),
                                  min=0,
                                  max=100,
                                  value=100)
                    ),
             ),
             column(9,
                    plotOutput("ukMapPlot", height="auto")
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