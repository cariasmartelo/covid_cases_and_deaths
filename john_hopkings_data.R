rm(list = ls())
library(tidyverse)

setwd("~/Google Drive/Escuela/MSCAPP/Q6/covid_gov_responses/covid_cases_and_deaths")

time_series_data_dir <- 'COVID-19/csse_covid_19_data/csse_covid_19_time_series'


# Loading world cases
world_cases <- read_csv(
  file.path(time_series_data_dir, 'time_series_covid19_confirmed_global.csv'))

# Loading US cases
us_cases <- read_csv(
  file.path(time_series_data_dir, 'time_series_covid19_confirmed_us.csv'))

states_and_territories <- us_cases %>%
  distinct(Province_State)

cases_by_state <- us_cases %>%
  select(-UID, -iso2, -iso3, -code3, -FIPS, -Admin2,
         -Country_Region, -Lat, -Long_, -Combined_Key) %>%
  group_by(Province_State) %>%
  summarise_all(sum)

View(cases_by_state)
            