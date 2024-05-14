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
load(here("02_attempt/data/training_data.rda"))

# Recipe 1
recipe_1 <- recipe(log_price ~ ., data = training_data) |>
  step_rm(id, host_has_profile_pic, property_type, host_has_profile_pic,
          host_identity_verified, has_availability, instant_bookable) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

# Recipe 2
recipe_2 <- recipe(log_price ~ ., data = training_data) |>
  # Feature engineering: Create a new feature for the ratio of host_listings_count to host_total_listings_count
  step_mutate(host_listings_ratio = host_listings_count / host_total_listings_count) |>
  step_rm(id, host_has_profile_pic, property_type, host_has_profile_pic,
          host_identity_verified, has_availability, instant_bookable,
          host_listings_count, host_total_listings_count) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_nzv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 
  
recipe_2 |>
  prep() |>
bake(new_data = NULL) |>
  glimpse()

save(recipe_1, file = here("02_attempt/recipes/recipe_1.rda"))
save(recipe_2, file = here("02_attempt/recipes/recipe_2.rda"))
