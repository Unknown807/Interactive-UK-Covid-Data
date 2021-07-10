# Interactive-UK-Covid-Data

Check it out on <a href="https://unknown807.shinyapps.io/covidrproj/">Shiny Apps</a>. Data currently being used is demo data and will only go up to the 09/07/2021.

## Description

This project uses R and the UK Government's <a href="https://coronavirus.data.gov.uk/details/developers-guide">Covid API</a> to create an interactive map showing daily cases and cumulative deaths across all of  the local authorities in the UK. Additionally showing a few charts which compare and visualise data in different ways. For example, comparing the cumulative deaths to net household income (since 2018) for each local authority.

## Libraries Used

- Shiny
- Leaflet
- Scales
- Ggplot2
- Tidyverse
- Sf
- Tmap
- Tmaptools

## How It Works

![](/imgs/img1.PNG)

The map shows you the daily cases and cumulative deaths (switch with radio buttons) for each local authority and there is a slider which lets you see this data for different dates since the data was made available via the API.

![](/imgs/img2.PNG)

The comparison page has three graphs which change from the inputs on the left. You can see the cumulative cases, deaths and daily cases for all UK regions or local authorities.
