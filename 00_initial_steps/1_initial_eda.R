#### Initial EDA

# Load package(s) 
library(tidymodels)
library(tidyverse)
library(here)

# Load data
load(here("data/training_data.rda"))
load(here("data/testing_data.rda"))

skimr::skim_without_charts(training_data)
