source('clean_data_helper.R')

require('jsonlite')

if(!exists("unclean.data")) {
  unclean.data <- fromJSON("https://data.healthcare.gov/resource/tqyt-hbvk.json")
}

if(!exists("unclean.2015.data")) {
  unclean.2015.data <- fromJSON("https://data.healthcare.gov/resource/b8in-sz6k.json?state=IL&county=COOK")
  save(unclean.2015.data, file = "unclean.2015.data.Rda")
}

