library(readr)
library(glue)
library(dplyr)
library(lubridate)

covidData <- function(){

  cols <- c('Country_Region', 'Last_Update', 'Confirmed', 'Deaths')

  link1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"
  link2 <- "csse_covid_19_data/csse_covid_19_daily_reports/"

  d <- lubridate::today() + lubridate::days(-1)
  d <- glue({ sprintf("%02d",lubridate::month(d)) },"-",
            { sprintf("%02d",lubridate::day(d)) },"-",
            { sprintf("%02d",lubridate::year(d)) })

  df <- read_csv(glue(link1, link2, {d}, ".csv"))

  df <- df[ , names(df) %in% cols] %>%
    filter_all(~ !is.na(.))

  return(df)
}

covidData()
