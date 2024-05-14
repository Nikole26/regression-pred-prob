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
load(here("01_attempt/data/training_data.rda"))

# Recipe
recipe_1 <- recipe(log_price ~ ., data = training_data) |>
  # Remove variables with high missing rates and low variance
  step_rm(id, host_has_profile_pic, property_type, host_has_profile_pic,
          host_identity_verified, has_availability, instant_bookable) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_1 |>
  prep() |>
bake(new_data = NULL) |>
  glimpse()

save(recipe_1, file = here("02_attempt/recipes/recipe_1.rda"))
