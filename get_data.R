source('clean_data_helper.R')

require('jsonlite')

if(!exists("unclean.data")) {
  unclean.data <- fromJSON("https://data.healthcare.gov/resource/b8in-sz6k.json?state=IL&county=COOK")
}
