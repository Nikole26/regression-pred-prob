# Model analysis and comparison

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
# Handle conflicts
tidymodels_prefer()

# load tune models ----
load(here("02_attempt/results/knn_tune_3.rda"))
load(here("02_attempt/results/bt_tune_3.rda"))
load(here("02_attempt/results/rf_tune_3.rda"))
load(here("02_attempt/results/svm_tune_3.rda"))

# Select the best hyperparameters for random forest
# For rf model
rf_best <- select_best(rf_tune_3, metric = "mae")

# For bt
bt_best <- select_best(bt_tune_3, metric = "mae")

# For kknn model
knn_best <- select_best(knn_tune_3, metric = "mae")

# Creating table
# all models results
model_results <- as_workflow_set(
  knn_3 = knn_tune_3,
  rf_3 = rf_tune_3,
  bt_3 = bt_tune_3,
  svm_3 = svm_tune_3
)

models_table_3 <- model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  select(wflow_id, mean, std_err) |>
  arrange(mean)

model_results |>
  autoplot(metric = "mae")

model_results |>
  autoplot(metric = "mae", select_best = TRUE)

