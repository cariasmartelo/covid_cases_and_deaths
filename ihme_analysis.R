#Covid gov Responses
#Script to download latest data from IHME
#

rm(list = ls())
library(tidyverse)
library(gridExtra)
# TO download latest proyections
# source('ihme_data_download.R')

# Set working directory
setwd("~/Google Drive/Escuela/MSCAPP/Q6/covid_gov_responses/covid_cases_and_deaths")
# Change to path where IHME csv's are
filepath <- "data/IHME"

# Import latest proyections
start_date <- '2020-02-15'
latest_proyection_csv <- '2020_04_20.02.all_Hospitalization_all_locs.csv'
first_proyection_csv <- 'ihme-covid19_ihme-covid19_all_locs.csv'
latest_proyections <- read_csv(file.path(filepath, latest_proyection_csv))
latest_proyections <- latest_proyections %>%
  filter(date > as.Date(start_date))

first_proyections <- read_csv(file.path(filepath, first_proyection_csv))
first_proyections <- first_proyections %>%
  rename(date = date_reported)
first_proyections <- first_proyections %>%
  filter(date > as.Date(start_date))

# Filter put NON-US
us_states <- c('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
               'Colorado', 'Connecticut','Delaware','Florida','Georgia',
               'Hawaii','Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas',
               'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts',
               'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana',
               'Nebraska', 'Nevada', 'New latest_proyecHampshire', 'New Jersey', 'New Mexico',
               'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma',
               'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina',
               'South Dakota', 'Tennessee', 'Texas', 'Utah', 'United States of America',
               'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin',
               'Wyoming')

keep_only_states <- function(df, states){
  return_df <- df %>%
    filter(location_name %in% states)
}

latest_proyections_us <- keep_only_states(latest_proyections, us_states)
first_proyections_us <- keep_only_states(first_proyections, us_states)


# Plot
states_to_plot <- c("New York", "Illinois", "California")
latest_proyections_plot<- keep_only_states(latest_proyections_us, states_to_plot) %>%
  ggplot(aes(x=date, y=deaths_mean)) +
  geom_line(aes(color=location_name)) +
  geom_vline(xintercept = as.Date('2020-04-20'), linetype = 'dashed') +
  ggtitle("Deaths by COVID, Projections April 20") +
  theme_bw()



# Do same proceedure with April 5 proyections

first_proyections_plot <- keep_only_states(first_proyections_us, states_to_plot) %>%
  ggplot(aes(x=date, y=deaths_mean)) +
  geom_line(aes(color=location_name)) +
  geom_vline(xintercept = as.Date('2020-03-25'), linetype = 'dashed') +
  ggtitle("Deaths by COVID, Projections March 25") +
  theme_bw()
  
summary(first_proyections_us$date)
summary(latest_proyections_us$date)

View(keep_only_states(latest_proyections_us, c('New York')))
# Show plots
grid.arrange(first_proyections_plot, latest_proyections_plot, nrow=2)
