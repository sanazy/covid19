% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/worldMapPlot.R
\name{worldMapPlot}
\alias{worldMapPlot}
\title{worldMapPlot}
\usage{
worldMapPlot(date, type)
}
\arguments{
\item{date}{specific date to show statics on that date}

\item{type}{death or all}
}
\description{
Plot distribution of death or all infections on world map
}
\examples{
worldMapPlot("2020-10-01", "death")
worldMapPlot("2020-10-05", "all")
}
