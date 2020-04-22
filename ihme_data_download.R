#Covid gov Responses
#Script to download latest data from IHME
#

rm(list = ls())
library(tidyverse)
library(httr)


filepath <- "data/IHME"

# We create a function to download csv from url with zipfile, extract csv and save to system
download_data <- function(url_of_download){
  # Create temporary file
  temp <- tempfile()
  # Download zip file into temporary
  download.file(url_of_download, temp)
  # Obtain the name of the csvfile to extract
  files <- unzip(temp, list=TRUE)$Name
  csv_file = NA
  for (file_downloaded in files){
    if (endsWith(file_downloaded, '.csv')){
      csv_file = file_downloaded
    }
  }
  
  # Extract the csv file using the name and read
  data <- read_csv(unz(temp, csv_file))
  
  # Discard temporary file with CSV
  unlink(temp)
  
  # Replace '/' in csv file name
  csv_file <- str_replace(csv_file, '/', '_')
  
  # Export csv to filepath
  write_csv(data, file.path(filepath, csv_file))
}
# List of previous proyections URL's
previous_proyections_urls <- c(
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-25/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-26/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-27/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-29/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-30/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-03-31/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-01/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-05/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-07/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-08/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-10/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-13/ihme-covid19.zip',
'https://ihmecovid19storage.blob.core.windows.net/archive/2020-04-17/ihme-covid19.zip')

# Download each of the previous proyections
# for (download_url in previous_proyections_urls){
#   download_data(download_url)
# }

# Download most recent download dile
latest_ihme_updated <- 'https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip'
download_data(latest_ihme_updated)



