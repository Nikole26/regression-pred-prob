# Knn Tune ----

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
load(here("03_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("03_attempt/recipes/recipe_2.rda"))

# model specifications ----
knn_model <-
  nearest_neighbor(mode = "regression",
                   neighbors = tune()) |>
  set_engine("kknn")

# define workflows ----
knn_wflow <- 
  workflow() |>
  add_model(knn_model) |>
  add_recipe(recipe_2)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_model)
# change hyperparameter ranges
knn_params <- parameters(knn_model) |>
  update(neighbors = neighbors(range = c(1, 10))) 

# build tuning grid
knn_grid <- grid_regular(knn_params, levels = 5)

# fit workflows/models ----
set.seed(1621)
knn_tune_2 <- tune_grid(knn_wflow,
                       air_bnb_folds,
                       grid = knn_grid,
                       metrics = metric_set(mae),
                       control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(knn_tune_2, file = here("03_attempt/results/knn_tune_2.rda"))
