#Covid gov Responses
#Script to download latest data from John Hompings and do come plots
#

rm(list = ls())
library(tidyverse)
library(httr)
#setwd("~/Google Drive/Escuela/MSCAPP/Q6/covid_gov_responses/covid_cases_and_deaths")

# URL of updated data
repository <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/'
cases_us_csv <- 'time_series_covid19_confirmed_US.csv'
cases_world_csv <- 'time_series_covid19_confirmed_global.csv'
deaths_us_csv <- 'time_series_covid19_deaths_US.csv'
deaths_world_csv <- 'time_series_covid19_deaths_global.csv'

# Downloading most recent CSV's
for (panel in c(cases_us_csv, cases_world_csv, deaths_us_csv, deaths_world_csv)){
  url_path <- file.path(repository, panel)
  filepath <- "data"
  GET(url_path, write_disk(file.path(filepath, panel), overwrite=TRUE))
}


# Loading cases
cases_us <- read_csv(file.path(filepath, cases_us_csv))
cases_world <- read_csv(file.path(filepath, cases_world_csv))
deaths_us <- read_csv(file.path(filepath, deaths_us_csv))
deaths_world <- read_csv(file.path(filepath, deaths_world_csv))


# Aggregate by state, creating average cases column
cases_by_state <- cases_us %>%
  select(-UID, -iso2, -iso3, -code3, -FIPS, -Admin2,
         -Country_Region, -Lat, -Long_, -Combined_Key) %>%
  group_by(Province_State) %>%
  summarise_all(sum)


# Optain most infected states
top_states <- cases_by_state %>%
  mutate(average_cases = rowMeans(.[-1], na.rm = TRUE)) %>%
  arrange(desc(average_cases)) %>%
  head(10) %>%
  select(Province_State) %>%
  pull(.)

# Convert by state to long
cases_by_state_long <- cases_by_state %>%
  gather("date", "cases", 2:ncol(cases_by_state)) %>%
  mutate(date = as.Date(date, format = "%m/%d/%y"))

# Plot most infected states
cases_by_state_long %>%
  filter(Province_State %in% top_states) %>%
  ggplot(aes(x = date, y = cases)) + 
  geom_line(aes(color = Province_State)) +
  theme_bw() +
  ggtitle("Cummulative confirmed cases by US state by day - 10 States with highest number") +
  scale_y_continuous(labels = comma) +
  ggsave(file.path('figures', 'cummulative_confirmed_us_states.png'))
  
