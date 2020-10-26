library(readr)
library(glue)
library(dplyr)
library(lubridate)
library(ggplot2)

timeSeriesPlot <- function(start_date, end_date, country_name) {

  diff <- as.numeric(as.Date(end_date) - as.Date(start_date))

  link <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"

  cols <- c('Country_Region', 'Last_Update',
            'Confirmed', 'Deaths')

  df_t = data.frame()

  for (day in c(-1:diff-1)) {

    d <- as.Date(start_date) + day
    d <- glue({ sprintf("%02d", lubridate::month(d)) }, "-",
              { sprintf("%02d", lubridate::day(d))   }, "-",
              { sprintf("%02d", lubridate::year(d))  })


    df <- read_csv(glue(link, {d}, ".csv"))

    df <- df[ , names(df) %in% cols] %>%
      filter(Country_Region == country_name)

    df_t <- rbind(df_t,df)
  }

  df_t <- df_t %>%
    mutate( Dead = Deaths - lag(Deaths, default = first(Deaths) ),
            All  = Confirmed - lag(Confirmed,
                                   default = first(Confirmed)) ) %>%
    slice(2:n())

  print(df_t)

  ggplot( data = df_t, aes(x = Last_Update) ) +
    geom_line( aes( y = All, colour = "All" ), size = 1) +
    geom_line( aes( y = Dead*10, colour = "Death" ), size = 1) +
    scale_y_continuous(sec.axis = sec_axis(~.*0.1,
                                           name = "Number of Deaths")) +
    scale_colour_manual(values = c("blue", "red"))+
    labs(y = "Number of Infections",
         x = "Date",
         colour = "Parameter") +
    theme(legend.position = c(0.1, 0.9))
}



timeSeriesPlot("2020-10-10", "2020-10-26", 'Iran')

