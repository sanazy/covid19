#' @title covidData
#'
#' @description Extract all data from John Hopkins Repository until today
#'
#' @return dataframe of name of countries, last update,
#'         number of deaths and infections
#'
#' @importFrom readr glue dplyr lubridate
#'
#' @examples df <- covidData()


covidData <- function(){

  # select few column names
  cols <- c('Country_Region', 'Last_Update', 'Confirmed', 'Deaths')

  # link of dataset
  link1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"
  link2 <- "csse_covid_19_data/csse_covid_19_daily_reports/"

  # calculate date in format of csv names
  d <- lubridate::today() + lubridate::days(-1)
  d <- glue::glue({ sprintf("%02d",lubridate::month(d)) },"-",
                  { sprintf("%02d",lubridate::day(d)) },"-",
                  { sprintf("%02d",lubridate::year(d)) })

  # read csv
  df <- readr::read_csv(glue::glue(link1, link2, {d}, ".csv"))

  # filter columns
  df <- df[ , names(df) %in% cols]

  # filter all NA values from rows
  df <- dplyr::filter_all(df, ~ !is.na(.))

  return(df)
}
