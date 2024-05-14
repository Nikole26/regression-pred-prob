# Regression Problem ----
# Processing training, creating resamples

# Load package(s)
library(tidymodels)
library(tidyverse)
library(here)

# handle common conflicts
tidymodels_prefer()

# read in training data -------
load(here("02_attempt/data/training_data.rda"))

# Initial split & resamples ----
#set.seed(6723)
#rideshare_split <- initial_split(rideshare_small, prop = 0.8, strata = price)

#rideshare_training <- training(rideshare_split)
#rideshare_testing <- testing(rideshare_split)

# create resamples (5-fold cv with 3 repeats) ----------
set.seed(3214)
air_bnb_folds <- training_data |>
  vfold_cv(v = 5, repeats = 3, log_price)

save(air_bnb_folds, file = here("02_attempt/data/air_bnb_folds.rda"))