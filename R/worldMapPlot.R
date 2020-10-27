#' @title worldMapPlot
#'
#' @description Plot distribution of death or all infections on world map
#'
#' @param date specific date to show statics on that date
#' @param type death or all
#'
#' @importFrom readr glue dplyr lubridate leaflet
#'
#' @examples
#' worldMapPlot("2020-10-01", "death")
#' worldMapPlot("2020-10-05", "all")


worldMapPlot <- function(date, type){

  # check first argument
  if (as.Date(date) < as.Date("2020-01-22")) {
    return(-1)
  }

  # check second argument
  if (type != 'death' & type != 'all') {
    return(-2)
  }

  cols <- c('Country_Region', 'Last_Update', 'Long_',
            'Lat', 'Confirmed', 'Deaths')

  link1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"
  link2 <- "csse_covid_19_data/csse_covid_19_daily_reports/"

  d <- as.Date(date)
  d <- glue::glue({ sprintf("%02d",lubridate::month(d)) },"-",
                  { sprintf("%02d",lubridate::day(d)) },"-",
                  { sprintf("%02d",lubridate::year(d)) })

  # read csv from specific date
  df <- readr::read_csv(glue::glue(link1, link2, {d}, ".csv"))

  # keep just some columns
  df <- df[ , names(df) %in% cols]

  # filter all NA rows from data
  df <- dplyr::filter_all(df, ~ !is.na(.))

  # determine label for plot
  if ( type == 'death'){
    label = df$Deaths
  } else if ( type == 'all'){
    label = df$Confirmed
  }

  # plot world map
  map <- leaflet::leaflet( df )
  map <- leaflet::setView( map =  map, lng = 0, lat = 0, zoom = 2 )
  map <- leaflet::addProviderTiles( map = map,
                                    leaflet::providers$Stamen.TonerLite )
  map <- leaflet::addMarkers( map =  map,
                              lng = df$Long_,
                              lat = df$Lat,
                              label = label,
                              clusterOptions = leaflet::markerClusterOptions())

  map
}


