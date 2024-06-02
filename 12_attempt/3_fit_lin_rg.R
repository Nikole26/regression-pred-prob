# Regression Problem ----
# Fit linear regression model

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(here)
library(stacks)

# Handle common conflicts
#tidymodels_prefer()

# load resamples/folds & controls
load(here("12_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("12_attempt/recipes/recipe_1.rda"))

# model specification ----
lin_reg_spec <-
  linear_reg() |>
  set_mode("regression") |>
  set_engine("lm")

# workflow ----
lin_reg_wflow <-
  workflow() |>
  add_model(lin_reg_spec) |>
  add_recipe(recipe_1)

# Tuning/fitting ----
ctrl_res <- control_stack_resamples()

lin_reg_res <-
  lin_reg_wflow |>
  fit_resamples(
    resamples = air_bnb_folds,
    metrics = metric_set(mae),
    control = ctrl_res
  )

# Write out results & workflow
save(lin_reg_res, file = here("12_attempt/results/lin_reg_res.rda"))
