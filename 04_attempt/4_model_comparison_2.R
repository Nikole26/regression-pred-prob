# Model analysis and comparison

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
# Handle conflicts
tidymodels_prefer()

# load tune models ----
#load(here("03_attempt/results/knn_tune_1.rda"))
load(here("04_attempt/results/bt_tune_2.rda"))
load(here("04_attempt/results/rf_tune_2.rda"))

# Creating table
# all models results
model_results <- as_workflow_set(
  rf = rf_tune_2,
  bt = bt_tune_2
)

models_table_2 <- model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  select(wflow_id, mean, std_err) |>
  arrange(mean)

model_results |>
  autoplot(metric = "mae")

model_results |>
  autoplot(metric = "mae", select_best = TRUE)

# Select the best hyperparameters for random forest
# For rf model
rf_best <- select_best(rf_tune_1, metric = "mae")

# For bt
bt_best <- select_best(bt_tune_2, metric = "mae")

# For kknn model
knn_best <- select_best(knn_tune_1, metric = "mae")
