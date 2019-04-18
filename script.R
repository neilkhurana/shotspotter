library(tidyverse)
library(tigris)
library(lubridate)

wilmington <- read_csv("http://justicetechlab.org/wp-content/uploads/2018/05/Wilmington_ShotspotterCAD_calls.csv",
                       col_types = cols(
                         calltime = col_datetime(format = "%m/%d/%Y %H:%M:%S"),
                         street = col_character(),
                         crossroad1 = col_character(),
                         crossroad2 = col_character(),
                         geox = col_double(),
                         geoy = col_double(),
                         nature = col_character(),
                         `FIRST UNIT DISPATCHED` = col_character(),
                         `first Dispatch Time` = col_character(),
                         `first unit on the way` = col_character(),
                         `first unit there` = col_character(),
                         `last unit to leave the scene` = col_character(),
                         primeunit = col_character(),
                         reptaken = col_double(),
                         closecode = col_character(),
                         notes = col_character(),
                         timeclose = col_character(),
                         Latitude = col_double(),
                         Longitude = col_double()
                       )) %>%
  filter(Latitude, Longitude) %>%
  select(calltime, Latitude, Longitude) %>%
  mutate(week = floor_date(calltime, "week"))


shapes <- urban_areas(class = "sf") %>%
  filter(NAME10 == "Wilmington, NC") 


