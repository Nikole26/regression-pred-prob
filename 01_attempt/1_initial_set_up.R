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

# create resamples (5-fold cv with 3 repeats) ----------
set.seed(2468)
air_bnb_folds <- training_data |>
  vfold_cv(v = 5, repeats = 3)

save(air_bnb_folds, file = here("01_attempt/data_splits/air_bnb_folds.rda"))
