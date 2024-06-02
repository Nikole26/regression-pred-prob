# Regression Problem ----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("07_attempt/results/bt_tune_2.rda"))
load(here("07_attempt/data/training_data.rda"))

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
save(final_fit, file = here("07_attempt/results/final_fit.rda"))

load(here("07_attempt/results/bt_tune_1.rda"))

# finalize workflow for roc-----
final_wflow_roc <- bt_tune_2 |>
  extract_workflow(bt_tune_2) |>
  finalize_workflow(select_best(bt_tune_2, metric = "mae"))

# train final model----
set.seed(110)
final_fit_1 <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit_1, file = here("07_attempt/results/final_fit_1.rda"))