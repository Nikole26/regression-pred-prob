# Regression Problem ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("05_attempt/results/bt_tune_1.rda"))
load(here("05_attempt/data/training_data.rda"))

# Best Model --------
select_best(rf_tune_1, metric = "mae")

# finalize workflow for roc-----
final_wflow_roc <- bt_tune_1 |>
  extract_workflow(bt_tune_1) |>
  finalize_workflow(select_best(bt_tune_1, metric = "mae"))

# train final model----
set.seed(132)
final_fit <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit, file = here("05_attempt/results/final_fit.rda"))
