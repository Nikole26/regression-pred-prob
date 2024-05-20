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
load(here("07_attempt/data/training_data.rda"))

# Recipe 1
recipe_1 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

# Recipe 2
recipe_2 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id) |>
  step_YeoJohnson(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_novel(all_nominal_predictors())|>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_2 |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

save(recipe_1, file = here("07_attempt/recipes/recipe_1.rda"))
save(recipe_2, file = here("07_attempt/recipes/recipe_2.rda"))

