install.packages("leaflet")

library(leaflet)
library(readr)
library(glue)
library(lubridate)


d  <- lubridate::today() + lubridate::days(-1)
d1 <- glue({sprintf("%02d",lubridate::month(d))},"-",
           {sprintf("%02d",lubridate::day(d))},"-",
           {sprintf("%02d",lubridate::year(d))})

link <- "https://raw.githubusercontent.com/CSSEGISandData/
COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"

df <- read_csv(glue(link, {d1}, ".csv"))

cols <- c('Country_Region', 'Last_Update',
          'Lat', 'Long_',
          'Confirmed', 'Deaths')

df <- df[ , names(df) %in% cols] %>%
  filter_all(~ !is.na(.))

head(df)


###############

leaflet() %>%
  addTiles() %>%
  addMarkers(lng = df$Long_,
             lat = df$Lat,
             clusterOptions = markerClusterOptions(),
             label = df$Deaths)


###########

library(ggplot2)
library(dplyr)
require(maps)
require(viridis)


world_map <- map_data("world")
ggplot(world_map,
       aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

ggplot(world_map) +
  #borders("world") +
  geom_polygon(fill="lightgray", colour = "red") +
  geom_point(data = df,
             aes(x = Long_,
                 y = Lat,
                 size = Deaths),
             alpha = 0.5)







