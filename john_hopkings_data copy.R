install.packages("coronavirus")
library(tidyverse)
library(coronavirus)

unique(coronavirus %>%
  filter(Country.Region == 'US') %>%
  select(type))


data(coronavirus)
colnames(coronavirus)
