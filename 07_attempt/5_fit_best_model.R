# Regression Prediction Problem - Attempt 1 ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("06_attempt/results/bt_tune_2.rda"))
load(here("06_attempt/data/training_data.rda"))

# Best Model --------
select_best(bt_tune_2, metric = "mae")

# finalize workflow for roc-----
final_wflow_roc <- bt_tune_2 |>
  extract_workflow(bt_tune_2) |>
  finalize_workflow(select_best(bt_tune_2, metric = "mae"))

# train final model----
set.seed(110)
final_fit <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit, file = here("06_attempt/results/final_fit.rda"))
