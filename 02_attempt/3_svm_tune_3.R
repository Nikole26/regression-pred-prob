# Regression Problem ----
# Tune SVM RBF model

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
load(here("02_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("02_attempt/recipes/recipe_3.rda"))

# model specification ----
svm_spec <-
  svm_rbf(
    cost = tune(),
    rbf_sigma = tune()
  ) |>
  set_mode("regression") |>
  set_engine("kernlab")

# # check tuning parameters
# hardhat::extract_parameter_set_dials(svm_spec)

# set-up tuning grid ----
svm_params <- hardhat::extract_parameter_set_dials(svm_spec)

# define grid
svm_grid <- grid_regular(svm_params, levels = 5)

# workflow ----
svm_wflow <-
  workflow() |>
  add_model(svm_spec) |>
  add_recipe(recipe_3)

# Tuning/fitting ----
set.seed(345)

ctrl_grid <- control_stack_grid()

svm_tune_3 <-
  svm_wflow |>
  tune_grid(
    resamples = air_bnb_folds,
    grid = svm_grid,
    metrics = metric_set(mae),
    control = ctrl_grid
  )

# Write out results & workflow
save(svm_tune_3, file = here("02_attempt/results/svm_tune_3.rda"))
