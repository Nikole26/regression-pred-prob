# Regression Prediction Problem - Attempt 1 ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("02_attempt/results/rf_tune_1.rda"))
load(here("02_attempt/data/training_data.rda"))

# Best Model --------
select_best(rf_tune_1, metric = "mae")

# finalize workflow for roc-----
final_wflow_roc <- rf_tune_1 |>
  extract_workflow(rf_tune_1) |>
  finalize_workflow(select_best(rf_tune_1, metric = "mae"))

# train final model----
set.seed(123)
final_fit <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit, file = here("02_attempt/results/final_fit.rda"))
