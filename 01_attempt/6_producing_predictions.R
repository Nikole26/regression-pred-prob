# Regression Problem ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("01_attempt/data/testing_data.rda"))
load(here("01_attempt/results/final_fit.rda"))

# producing predictions
attempt_01_rf_01 <- testing_data |>
  bind_cols(predict(final_fit, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_01_rf_01, here("submissions/attempt_01_rf_01.csv"))
