# Model analysis and comparison

# Load package(s) ----
library(tidyverse)
library(tidymodels)
library(tictoc)
library(here)
# Handle conflicts
tidymodels_prefer()

# load tune models ----
load(here("08_attempt/results/bt_tune_1.rda"))
load(here("08_attempt/results/bt_tune_2.rda"))
load(here("08_attempt/results/bt_tune_3.rda"))
load(here("08_attempt/results/bt_tune_4.rda"))

# Creating table
# all models results
model_results <- as_workflow_set(
  bt_1 = bt_tune_1,
  bt_2 = bt_tune_2,
  bt_3 = bt_tune_3,
  bt_4 = bt_tune_4
)

models_table <- model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  select(wflow_id, mean, std_err) |>
  mutate(recipe = c("recipe 1", "recipe 2", "recipe 3", "recipe 4")) |> 
  arrange(mean)

save(models_table, file = here("08_attempt/results/models_table.rda"))

model_results |>
  autoplot(metric = "mae")

model_results |>
  autoplot(metric = "mae", select_best = TRUE)

select_best(bt_tune_4, metric = "mae") 

save(bt_autoplot, file = here("12_attempt/results/bt_autoplot.rda"))
