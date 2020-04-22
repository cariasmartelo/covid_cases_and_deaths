#Covid gov Responses
#Script to download latest data from IHME
#

rm(list = ls())
library(tidyverse)
library(gridExtra)
# TO download latest proyections
source('ihme_data_download.R')

filepath <- "data/IHME"

# Import latest proyections
latest_proyections <- read_csv(file.path(filepath, '2020_04_20.02.all_Hospitalization_all_locs.csv'))
# Filter NON-US
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

latest_proyections_us <- latest_proyections %>%
  filter(location_name %in% us_states)


latest_proyections_us_ny_ca_mi <- latest_proyections_us %>%
  filter(location_name == 'New York' | location_name == 'California' | location_name == 'Illinois')


latest_proyections_plot_ny_ca_mi <- latest_proyections_us_ny_ca_mi %>%
  ggplot(aes(x=date, y=deaths_mean)) +
  geom_line(aes(color=location_name)) +
  geom_vline(xintercept = as.Date('2020-04-20'), linetype = 'dashed') +
  ggtitle("Deaths by COVID, Proyections April 20") +
  theme_bw()




april_5 <- read_csv(file.path(filepath, '2020_04_05.08.all_Hospitalization_all_locs.csv'))
april_5_us <- april_5 %>%
  filter(location_name %in% us_states)

april_5_us_ny_ca_mi <- april_5_us %>%
  filter(location_name == 'New York' | location_name == 'California' | location_name == 'Illinois')

april_5_us_ny_ca_mi <- april_5_us_ny_ca_mi %>%
  ggplot(aes(x=date, y=deaths_mean)) +
  geom_line(aes(color=location_name)) +
  geom_vline(xintercept = as.Date('2020-04-05'), linetype = 'dashed') +
  ggtitle("Deaths by COVID, Proyections April 8") +
  theme_bw()
  


grid.arrange(april_5_us_ny_ca_mi, latest_proyections_plot_ny_ca_mi, nrow=2)
