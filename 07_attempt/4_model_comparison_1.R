# Model analysis and comparison

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
# Handle conflicts
tidymodels_prefer()

# load tune models ----
load(here("07_attempt/results/bt_tune_1.rda"))
load(here("07_attempt/results/rf_tune_1.rda"))

# Select the best hyperparameters for random forest
# For rf model
rf_best <- select_best(rf_tune_1, metric = "mae")

# For bt
bt_best <- select_best(bt_tune_1, metric = "mae")

# For kknn model
knn_best <- select_best(knn_tune_1, metric = "mae")

# Creating table
# all models results
model_results <- as_workflow_set(
  #rf = rf_tune_1,
  bt = bt_tune_2
)

models_table_1 <- model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  select(wflow_id, mean, std_err) |>
  arrange(mean)

model_results |>
  autoplot(metric = "mae")

model_results |>
  autoplot(metric = "mae", select_best = TRUE)

