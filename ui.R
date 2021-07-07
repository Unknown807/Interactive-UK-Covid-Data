
ui <- navbarPage(title="UK Covid Data Visualised",
  tabPanel(title="Maps",
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Options"),
                      radioButtons("dataRadioType",
                                   h5("Data"),
                                   choices = list("Cumulative Cases"=1,
                                                  "Cumulative Deaths"=2),
                                   selected=1),
                      radioButtons("mapRadioType",
                                  h5("Map"),
                                  choices = list("Countries"=1,
                                                 "Authorities"=2),
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