# Regression Problem ----
# Processing training, creating resamples

# Load package(s)
library(tidymodels)
library(tidyverse)
library(here)

# handle common conflicts
tidymodels_prefer()

# read in training data -------
load(here("data/training_data.rda"))

# create resamples (10-fold cv with 5 repeats) ----------
set.seed(2468)
air_bnb_folds <- training_data |>
  vfold_cv(v = 4, repeats = 2)

save(air_bnb_folds, file = here("01_attempt/data_splits/air_bnb_folds.rda"))
