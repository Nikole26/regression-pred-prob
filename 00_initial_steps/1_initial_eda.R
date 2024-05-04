#### Initial EDA

# Load package(s) 
library(tidymodels)
library(tidyverse)
library(here)

# Load data
load(here("data/training_data.rda"))
load(here("data/testing_data.rda"))

skimr::skim_without_charts(training_data)


# Target variable distribution
air_bnb_data |>
  ggplot(aes (x = price) ) +
  geomline() +
  labs (y = "Count" , x = "Superhost Status") +
  theme_classic() + theme (legend.position = "none") +
  scale_fill_manual(values = c("darkgreen", "green"))

# Check correlations-----------
cor_matrix <- air_bnb_data |>
  select (where(is.numeric) | where(is.logical)) |>
  na.omit() |> 
  cor() |>
  as_tibble( )
