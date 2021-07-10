
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
                                   h5("Authorities Scatter Options"),
                                   choices = list("Cumulative Cases"=1,
                                                  "Cumulative Deaths"=2),
                                   selected=1),
                      hr(),
                      helpText("This displays daily cases only"),
                      selectInput("authoritySelect",
                                  h5("Authorities"),
                                  choices=authoritiesList,
                                  selected=authoritiesList[1]),
                      hr(),
                      radioButtons("regionDataRadioType",
                                  h5("Region Options"),
                                  choices = list("Cumulative Cases"=1,
                                                 "Cumulative Deaths"=2),
                                  selected=1),
                      selectInput("regionSelect",
                                  h5("Regions"),
                                  choices = list("England", 
                                                 "Scotland", 
                                                 "Wales", 
                                                 "Northern Ireland"),
                                  selected="England")
                    )
             ),
             column(9,
                    fluidRow(
                      plotOutput("authorityScatterPlot")
                    ),
                    fluidRow(
                      plotOutput("authorityLinePlot")
                    ),
                    fluidRow(
                      plotOutput("regionPlot")
                    )
             )
           )
  ),
  tabPanel(title="About",
           fluidRow(
             column(12,
                    h3("Visualising Covid Data Using R - By Milovan Gveric"),
                    h4("My first data science project where I aimed to use data 
                    that was currently relevant and visualise it in a few interesting
                    ways. The source code for the project can be seen ",
                    tags$a(href="https://github.com/Unknown807/", "here"))
             )
           )
  ),
  tags$head(includeCSS("styles\\styles.css"))
)