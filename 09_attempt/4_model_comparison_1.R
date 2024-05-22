# Model analysis and comparison

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
# Handle conflicts
tidymodels_prefer()

# load tune models ----
load(here("09_attempt/results/bt_tune_1.rda"))
load(here("09_attempt/results/bt_tune_2.rda"))
load(here("09_attempt/results/bt_tune_3.rda"))
load(here("09_attempt/results/bt_tune_4.rda"))
load(here("09_attempt/results/bt_tune_5.rda"))
load(here("09_attempt/results/bt_tune_6.rda"))

# Creating table
# all models results
model_results <- as_workflow_set(
  bt_1 = bt_tune_1,
  bt_2 = bt_tune_2,
  bt_3 = bt_tune_3,
  bt_4 = bt_tune_4,
  bt_5 = bt_tune_5,
  bt_6 = bt_tune_6
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

