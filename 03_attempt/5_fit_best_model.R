# Regression Problem----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("03_attempt/results/rf_tune_2.rda"))
load(here("03_attempt/data/training_data.rda"))

# Best Model --------
select_best(rf_tune_2, metric = "mae")

# finalize workflow for roc-----
final_wflow_roc <- rf_tune_2 |>
  extract_workflow(rf_tune_2) |>
  finalize_workflow(select_best(rf_tune_2, metric = "mae"))

# train final model----
set.seed(142)
final_fit <- fit(final_wflow_roc, training_data)

# saving results-------
save(final_fit, file = here("03_attempt/results/final_fit.rda"))
