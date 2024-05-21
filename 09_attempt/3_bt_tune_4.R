# Bt Real Tune ----

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
library(parallel)
library(doParallel)
library(bonsai)

# Handle conflicts
tidymodels_prefer()

# parallel processing ----
num.cores <- detectCores(logical = TRUE)
registerDoParallel(cores = num.cores/2)

# load resamples/folds & controls
load(here("08_attempt/data/air_bnb_folds.rda"))

# load pre-processing/feature engineering/recipe
load(here("08_attempt/recipes/recipe_4.rda"))

# model specifications ----
bt_model <- boost_tree(mode = "regression", 
                       mtry = tune(),
                       min_n = tune(),
                       learn_rate = tune()) |> 
  set_engine("lightgbm")

# define workflows ----
bt_wflow <- 
  workflow() |>
  add_model(bt_model) |>
  add_recipe(recipe_4)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(bt_model)
# change hyperparameter ranges
bt_params <- parameters(bt_model) |>
  update(mtry = mtry(c(5, 22)), 
         min_n = min_n(c(15, 25)),
          learn_rate = learn_rate(c(-1, 2))) 
# build tuning grid
bt_grid <- grid_regular(bt_params, levels = 5)

# fit workflows/models ----
#set seed
set.seed(120)
bt_tune_4 <- tune_grid(bt_wflow,
                      air_bnb_folds,
                      grid = bt_grid,
                      metrics = metric_set(mae),
                      control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(bt_tune_4, file = here("08_attempt/results/bt_tune_4.rda"))
