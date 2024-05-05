#### Initial EDA

# Load package(s) 
library(tidymodels)
library(tidyverse)
library(here)

# Load data
load(here("data/training_data.rda"))
load(here("data/testing_data.rda"))

skimr::skim_without_charts(training_data)

# 

# Target variable distribution
ggplot(data = your_data, aes(y = price)) +
  geom_boxplot() +
  ylab("Price") +
  ggtitle("Box Plot of Price Distribution")

# Check correlations-----------
cor_matrix <- air_bnb_data |>
  select (where(is.numeric) | where(is.logical)) |>
  na.omit() |> 
  cor() |>
  as_tibble( )
