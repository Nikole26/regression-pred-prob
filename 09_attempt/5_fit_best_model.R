# Regression Problem ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("09_attempt/results/bt_tune_5.rda"))
load(here("09_attempt/data/training_data.rda"))

# Best Model --------
select_best(bt_tune_4, metric = "mae")

# finalize workflow for roc-----
final_wflow <- bt_tune_5 |>
  extract_workflow(bt_tune_5) |>
  finalize_workflow(select_best(bt_tune_5, metric = "mae"))

# train final model----
set.seed(110)
final_fit <- fit(final_wflow, training_data)

# saving results-------
save(final_fit, file = here("09_attempt/results/final_fit.rda"))
