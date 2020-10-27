#' @title timeSeriesPlot
#'
#' @description Time Series Plot to show distribution of death and
#'     all infections for specific country and specific time range
#'
#' @param start_date start date of time range
#' @param end_date end date of time range
#' @param country_name name of specific country
#'
#' @importFrom readr glue dplyr lubridate ggplot2 purrr
#'
#' @examples
#' timeSeriesPlot("2020-10-01", "2020-10-25", "Iran")


timeSeriesPlot <- function(start_date, end_date, country_name) {

  # check start_date is larger than 2020-01-22
  if (as.Date(start_date) < as.Date("2020-01-22")) {
    return(-1)
  }

  # check end_date larger than start_date
  if (as.Date(start_date) > as.Date(end_date)) {
    return(-2)
  }

  # days between end_date and start_date
  diff <- as.numeric(as.Date(end_date) - as.Date(start_date))

  link1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"
  link2 <- "csse_covid_19_data/csse_covid_19_daily_reports/"

  # selected column names
  cols <- c('Country_Region', 'Last_Update', 'Confirmed', 'Deaths')

  # empty dataframe
  df_t = data.frame()

  # define pipe operation
  `%>%` <- purrr::`%>%`

  # loop for days between start and end date
  for (day in c(-1:diff-1)) {

    d <- as.Date(start_date) + day
    d <- glue::glue({ sprintf("%02d", lubridate::month(d)) }, "-",
                    { sprintf("%02d", lubridate::day(d))   }, "-",
                    { sprintf("%02d", lubridate::year(d))  })


    df <- readr::read_csv(glue::glue(link1, link2, {d}, ".csv"))

    # filter columns and country_name
    df <- df[ , names(df) %in% cols] %>%
      dplyr::filter(Country_Region == country_name)

    # append data to df_t
    df_t <- rbind(df_t,df)
  }

  # calculate number of death and all for each day by subtracting
  # cumulative data from previous day
  df_t <- df_t %>%
    dplyr::mutate(Dead = Deaths - dplyr::lag(Deaths,
                                             default = dplyr::first(Deaths) ),
                  All = Confirmed - dplyr::lag(Confirmed,
                                               default = dplyr::first(Confirmed)))

  # remove first row because it is useless
  df_t <- df_t[-1,]

  # plot
  p <- ggplot2::ggplot( data = df_t, ggplot2::aes(x = Last_Update) )

  p <- p + ggplot2::geom_line( ggplot2::aes( y = All, colour = "All" ),
                               size = 1 )

  p <- p + ggplot2::geom_line( ggplot2::aes( y = Dead*10, colour = "Death" ),
                               size = 1 )

  p <- p + ggplot2::scale_y_continuous(
     sec.axis = ggplot2::sec_axis( ~.*0.1,
                                   name = "Number of Deaths") )

  p <- p + ggplot2::scale_colour_manual( values = c("blue", "red") )

  p <- p + ggplot2::labs( y = "Number of Infections",
                          x = "Date",
                          colour = "Parameter" )

  p <- p + ggplot2::theme( legend.position = c(0.1, 0.9) )

  p
}

