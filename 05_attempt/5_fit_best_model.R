# Regression Prediction Problem - Attempt 1 ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("04_attempt/results/rf_tune_1.rda"))
load(here("04_attempt/results/bt_tune_2.rda"))
load(here("04_attempt/data/training_data.rda"))

# Best Model --------
select_best(rf_tune_1, metric = "mae")

# finalize workflow for roc-----
final_wflow_roc <- rf_tune_1 |>
  extract_workflow(rf_tune_1) |>
  finalize_workflow(select_best(rf_tune_1, metric = "mae"))

# train final model----
set.seed(113)
final_fit <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit, file = here("04_attempt/results/final_fit.rda"))

# Best Model 2--------
select_best(bt_tune_2, metric = "mae")

# finalize workflow for mae-----
final_wflow_roc <- bt_tune_2 |>
  extract_workflow(bt_tune_2) |>
  finalize_workflow(select_best(bt_tune_2, metric = "mae"))

# train final model----
set.seed(162)
final_fit_2 <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit_2, file = here("04_attempt/results/final_fit_2.rda"))
