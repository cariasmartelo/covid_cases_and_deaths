#Covid gov Responses
#Script to download latest data from IHME
#

rm(list = ls())
library(tidyverse)
library(httr)
#setwd("~/Google Drive/Escuela/MSCAPP/Q6/covid_gov_responses/covid_cases_and_deaths")

# URL of updated data
latest_ihme_updated <- 'https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip'
# repository <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/'
# cases_us_csv <- 'time_series_covid19_confirmed_US.csv'
# cases_world_csv <- 'time_series_covid19_confirmed_global.csv'
# deaths_us_csv <- 'time_series_covid19_deaths_US.csv'
# deaths_world_csv <- 'time_series_covid19_deaths_global.csv'


# URL de decsarga
latest_ihme_updated <- 'https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip'
# Creas archivo temporal
temp <- tempfile()
# Descargas zip y lo pones en archivo temporal
download.file(latest_ihme_updated,temp)
# Obtengo el nombre del archivo dentro del zip que quiero extraer
filename <- unzip(temp, list=TRUE)$Name[2]
# Extraigo del archivo temporal el archivo que indiqué
data <- read_csv(unz(temp, filename))
# Bye archivo temporal
unlink(temp)

View(data)
