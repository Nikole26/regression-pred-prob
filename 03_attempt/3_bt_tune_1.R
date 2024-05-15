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
load(here("03_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("03_attempt/recipes/recipe_1.rda"))

# model specifications ----
bt_model <- boost_tree(mode = "regression", 
                       mtry = tune(),
                       min_n = tune(),
                       learn_rate = tune()) |> 
  set_engine("xgboost")

# define workflows ----
bt_wflow <- 
  workflow() |>
  add_model(bt_model) |>
  add_recipe(recipe_1)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(bt_model)
# change hyperparameter ranges
bt_params <- parameters(bt_model) |>
  update(mtry = mtry(c(1, 10)), 
         learn_rate = learn_rate(c(-5, -0.2))) 
# build tuning grid
bt_grid <- grid_regular(bt_params, levels = 5)

# fit workflows/models ----
#set seed
set.seed(1720)
bt_tune_1 <- tune_grid(bt_wflow,
                      air_bnb_folds,
                      grid = bt_grid,
                      metrics = metric_set(mae),
                      control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(bt_tune_1, file = here("03_attempt/results/bt_tune_1.rda"))
