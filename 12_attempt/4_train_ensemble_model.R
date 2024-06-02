# Regression Problem ----
# Train & explore ensemble model

# Load package(s) ----
library(tidymodels)
library(tidyverse)
library(here)
library(stacks)
library(bonsai)
library(parsnip)

# Handle common conflicts
tidymodels_prefer()

# Load candidate model info ----
load(here("12_attempt/results/svm_res.rda"))
load(here("12_attempt/results/lin_reg_res.rda"))
load(here("12_attempt/results/knn_res.rda"))
load(here("12_attempt/results/bt_tune_1.rda"))

# Create data stack ----
air_bnb_stack_original <- stacks() |>
  add_candidates(knn_res) |>
  add_candidates(svm_res) |>
  add_candidates(lin_reg_res) |>
  add_candidates(bt_tune_1) 

save(air_bnb_stack_original, file = here("12_attempt/results/air_bnb_stack_original.rda"))

# Fit the stack ----
# penalty values for blending (set penalty argument when blending)
blend_penalty <- c(10^(-6:-1), 0.5, 1, 1.5, 2)

# Blend predictions (tuning step, set seed)
set.seed(130)
air_bnb_stack <- air_bnb_stack_original |>
  blend_predictions(penalty = blend_penalty)

# Save blended model stack
save(air_bnb_stack, file = here("12_attempt/results/air_bnb_stack.rda"))

# Explore the blended model stack
summary_plot <- autoplot(air_bnb_stack)
coefficient_plot <- autoplot(air_bnb_stack, type = "weights")

save(summary_plot, file = here("12_attempt/results/summary_plot.rda"))
save(coefficient_plot, file = here("12_attempt/results/coefficient_plot.rda"))

# fit to training set ----
air_bnb_final <- air_bnb_stack |>
  fit_members()

# Save trained ensemble model
save(air_bnb_final, file = here("12_attempt/results/air_bnb_final.rda"))
summary(air_bnb_final)

# Explore parameters --------
knn_members <- air_bnb_final |>
  collect_parameters(candidates = "knn_res") |>
  filter(coef != 0)

svm_members <- air_bnb_final |>
  collect_parameters(candidates = "svm_res") |>
  filter(coef != 0)

lm_members <- air_bnb_final |>
  collect_parameters(candidates = "lin_reg_res") |>
  filter(coef != 0)

bt_members <- air_bnb_final |>
  collect_parameters(candidates = "bt_tune_1") |>
  filter(coef != 0)

all_members <- bind_rows(
  knn_members,
  svm_members,
  lm_members,
  bt_members
) |>
  arrange(desc(coef))
