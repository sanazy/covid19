#install.packages(c("devtools", "usethis", "knitr", "rmarkdown",
#                   "roxygen2", "pkgdown", "processx"))

# libraries
library(processx)
library(devtools)
library(roxygen2)
library(usethis)
library(rmarkdown)
library(knitr)
library(pkgdown)

# git
usethis::use_git()
usethis::use_github()
usethis::git_sitrep()

# create function files
usethis::use_r("covidData")
usethis::use_r("worldMapPlot")
usethis::use_r("timeSeriesPlot")

# License
usethis::use_mit_license("sanazy")

# Execute package
usethis::use_package("readr")
usethis::use_package("glue")
usethis::use_package("dplyr")
usethis::use_package("lubridate")
usethis::use_package("leaflet")
usethis::use_package("ggplot2")
usethis::use_package("purrr")

devtools::install()
covid19::covidData()
covid19::worldMapPlot("2020-10-01", "death")
covid19::timeSeriesPlot("2020-10-02", "2020-10-03", "Iran")

# Guide for functions
usethis::use_roxygen_md()
devtools::document()

# Readme
usethis::use_readme_rmd()

# Vignette
usethis::use_vignette("covid19", "Explore covid-19 dataset")
devtools::check()
devtools::install(build_vignettes = TRUE)

# Test
usethis:: use_testthat()
usethis:: use_test("worldMapPlot")
usethis:: use_test("timeSeriesPlot")
devtools::test()

# Create site
pkgdown::build_site()




