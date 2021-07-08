
library(httr)
library(jsonlite)
library(dplyr)

ENDPOINT <- "https://api.coronavirus.data.gov.uk/v1/data"

structure <- list(
  date  = "date", 
  name  = "areaName",
  code = "areaCode",
  dailyCases = "newCasesByPublishDate",
  cumulativeCases = "cumCasesByPublishDate",
  dailyDeaths = "newDeaths28DaysByPublishDate",
  cumulativeDeaths = "cumDeaths28DaysByPublishDate"
)

getData <- function(area_type, csv_file_name) {
  
  current_page_num <- 1
  allData <- NULL
  
  repeat{
    response <- GET(
      url = ENDPOINT,
      query = list(
        filters = paste("areaType=", area_type, sep="", collapse=";"),
        structure = toJSON(structure, auto_unbox=TRUE),
        page=as.character(current_page_num)
      ),
      timeout(10)
    )
    
    if (response$status_code >= 400) {
      err_msg = http_status(response)
      stop(err_msg)
    }
    
    json_text <- content(response, "text")
    data <- fromJSON(json_text)
    
    if (is.null(allData)) {
      allData <- data$data
    } else {
      allData <- rbind(allData, data$data)
    }
    
    print(paste("Fetched Page",current_page_num))
    
    if (is.null(data$pagination$`next`)) {
      break
    }
    
    current_page_num <- current_page_num + 1
  }
  
  write.csv(allData, csv_file_name, na="0", row.names = TRUE)
  
}

getCountries <- function () {
  area_type = "nation"
  csv_file_name = "resources\\countries.csv"
  getData(area_type, csv_file_name)
}

getAuthorities <- function() {
  area_type = "ltla"
  csv_file_name = "resources\\authorities.csv"
  getData(area_type, csv_file_name)
}


# getCountries()
getAuthorities()
