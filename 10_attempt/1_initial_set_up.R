# Regression Problem ----
# Processing training, creating resamples

# Load package(s)
library(tidymodels)
library(tidyverse)
library(here)

# handle common conflicts
tidymodels_prefer()

# read in training data -------
load(here("08_attempt/data/training_data.rda"))

# Initial split & resamples ----
# create resamples (5-fold cv with 3 repeats) ----------
set.seed(120)
air_bnb_folds <- training_data |>
  vfold_cv(v = 5, repeats = 3, log_price)

save(air_bnb_folds, file = here("08_attempt/data/air_bnb_folds.rda"))
