# Bt Real Tune ----

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
library(parallel)
library(doParallel)

# Handle conflicts
tidymodels_prefer()

# parallel processing ----
num.cores <- detectCores(logical = TRUE)
registerDoParallel(cores = num.cores/2)

# load resamples/folds & controls
load(here("07_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("07_attempt/recipes/recipe_2.rda"))

# model specifications ----
rf_model <-
  rand_forest(
    trees = 1000, 
    min_n = tune(),
    mtry = tune()
  ) |>
  set_mode("regression") |>
  set_engine("ranger")

# define workflows ----
rf_wflow <- 
  workflow() |>
  add_model(rf_model) |>
  add_recipe(recipe_2)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(rf_model)

# change hyperparameter ranges
rf_params <- parameters(rf_model) %>% 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(mtry = mtry(c(5, 20))) 

# build tuning grid
rf_grid <- grid_regular(rf_params, levels = 5)

# fit workflows/models ----
set.seed(150)
rf_tune_2 <- tune_grid(rf_wflow,
                      air_bnb_folds,
                      grid = rf_grid,
                      metrics = metric_set(mae),
                      control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(rf_tune_2, file = here("07_attempt/results/rf_tune_2.rda"))



