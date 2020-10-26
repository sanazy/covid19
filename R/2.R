library(readr)
library(glue)
library(lubridate)
library(leaflet)

worldMapPlot <- function(date, type){

  cols <- c('Country_Region', 'Last_Update', 'Long_',
            'Lat', 'Confirmed', 'Deaths')

  link1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"
  link2 <- "csse_covid_19_data/csse_covid_19_daily_reports/"

  d <- as.Date(date)
  d <- glue({ sprintf("%02d",lubridate::month(d)) },"-",
            { sprintf("%02d",lubridate::day(d)) },"-",
            { sprintf("%02d",lubridate::year(d)) })

  df <- read_csv(glue(link1, link2, {d}, ".csv"))

  df <- df[ , names(df) %in% cols] %>%
    filter_all(~ !is.na(.))

  if ( type == 'death'){
    label = df$Deaths
  } else if ( type == 'all'){
    label = df$Confirmed
  }

  df %>%
    leaflet() %>%
    setView(lng = 0, lat = 0, zoom = 2) %>%
    addProviderTiles(providers$Stamen.TonerLite) %>%
    addMarkers( lng = df$Long_,
                lat = df$Lat,
                label = label,
                clusterOptions = markerClusterOptions())
}

worldMapPlot("2020-10-24", 'death')
