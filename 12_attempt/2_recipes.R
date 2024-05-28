# Regression Problem ----
# Setup preprocessing/recipes/feature engineering

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(here)
library(recipes)

# handle common conflicts
tidymodels_prefer()

# loading training data -------
load(here("12_attempt/data/training_data.rda"))

# Recipe 1
recipe_1 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_verifications, host_response_time) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_novel(all_nominal_predictors()) |>
  step_unknown(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_1 |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

save(recipe_1, file = here("12_attempt/recipes/recipe_1.rda"))

