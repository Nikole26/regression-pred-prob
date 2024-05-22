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
load(here("09_attempt/data/training_data.rda"))

# Recipe 1
recipe_1 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications, first_review_year, last_review_year) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_novel(all_nominal_predictors()) |>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_2 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications, first_review_year, last_review_year,
          property_type) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_novel(all_nominal_predictors()) |>
  step_unknown(all_nominal_predictors()) |>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_3 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications, first_review_year, last_review_year,
          property_type, year_since) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_novel(all_nominal_predictors()) |>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_4 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications, first_review_year, last_review_year,
          property_type, year_since) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_5 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_6 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_response_time, host_verifications, property_type, year_since) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_knn(all_predictors()) |>
  step_other(all_nominal_predictors(), threshold = 0.05) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

recipe_6 |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

save(recipe_1, file = here("09_attempt/recipes/recipe_1.rda"))
save(recipe_2, file = here("09_attempt/recipes/recipe_2.rda"))
save(recipe_3, file = here("09_attempt/recipes/recipe_3.rda"))
save(recipe_4, file = here("09_attempt/recipes/recipe_4.rda"))
save(recipe_5, file = here("09_attempt/recipes/recipe_5.rda"))
save(recipe_6, file = here("09_attempt/recipes/recipe_6.rda"))

