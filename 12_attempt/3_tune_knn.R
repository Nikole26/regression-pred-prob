# L07 Ensemble Models ----
# Tune KNN model

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(here)
library(stacks)
library(parallel)
library(doParallel)

# Handle common conflicts
tidymodels_prefer()

# parallel processing ----
num.cores <- detectCores(logical = TRUE)
registerDoParallel(cores = num.cores/2)

# load resamples/folds & controls
load(here("12_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("12_attempt/recipes/recipe_1.rda"))

# model specification ----
knn_spec <-
  nearest_neighbor(
    neighbors = tune()
  ) |>
  set_mode("regression") |>
  set_engine("kknn")

# # check tuning parameters
hardhat::extract_parameter_set_dials(knn_spec)

# set-up tuning grid ----
knn_params <- hardhat::extract_parameter_set_dials(knn_spec) |>
  update(neighbors = neighbors(range = c(1,40)))

# define grid
knn_grid <- grid_regular(knn_params, levels = 15)

# workflow ----
knn_wflow <-
  workflow() |>
  add_model(knn_spec) |>
  add_recipe(recipe_1)

# Tuning/fitting ----
set.seed(213)

ctrl_grid <- control_stack_grid()

knn_res <-
  knn_wflow |>
  tune_grid(
    resamples = air_bnb_folds,
    grid = knn_grid,
    metrics = metric_set(mae),
    control = ctrl_grid
  )

# Write out results & workflow
save(knn_res, file = here("12_attempt/results/knn_res.rda"))
