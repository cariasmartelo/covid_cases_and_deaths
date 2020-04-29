#Covid gov Responses
#Script to download latestdata about testing from Covid Tracking Project
#

rm(list=ls())
library(tidyverse)

filepath <- "data/testing"

# URL of updated data
current_states <- 'https://covidtracking.com/api/v1/states/current.csv'
historical_states <- 'https://covidtracking.com/api/v1/states/daily.csv'

# Download files
download.file(current_states, destfile = file.path(filepath, 'current_states.csv'))
download.file(historical_states, destfile = file.path(filepath, 'historical_states.csv'))

# Load files
current_states_testing <- read_csv(file.path(filepath, 'current_states.csv'))
historical_states_testing <- read_csv(file.path(filepath, 'historical_states.csv'))
historical_states_testing <- historical_states_testing %>%
  mutate(date = as.Date(as.character(date), '%Y%m%d')) %>%
  mutate(positive_ratio = positive / totalTestResults)

# Historial summary statistics
historical_states_testing %>%
  group_by(state) %>%
  summarise(firts_date = min(date), last_date = max(date), n = n())

select_states <-  c('NY', 'IL', 'CA', 'NC', 'FL')

A_grade_states <- current_states_testing %>%
  filter(grade == 'A') %>%
  pull(state)

Top_10_states <- current_states_testing %>%
  arrange(desc(totalTestResults)) %>%
  head(10) %>%
  pull(state)

A_grade_states
Top_10_states

historical_states_testing %>%
  filter(state %in% A_grade_states & state %in% Top_10_states) %>%
  ggplot(aes(x=date, y=positive_ratio)) +
  geom_line(aes(color=state)) +
  theme_minimal()
View(current_states_testing)
