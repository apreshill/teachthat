#' ---
#' output: github_document
#' ---

#' Use the development version of tidyr from GitHub:
#+ devversion, eval = FALSE
# install.packages("devtools")
devtools::install_github("tidyverse/tidyr")

#+ packages, warning = FALSE, message = FALSE
library(dplyr)
library(tidyr)

juniors_jumbled <- tibble::tribble(
    ~baker, ~var_name, ~var_value,
    "Emma",     "age",       "11",
   "Harry",     "age",       "10",
    "Ruby",     "age",       "11",
  "Zainab",     "age",       "10",
    "Emma", "outcome", "finalist",
   "Harry", "outcome",   "winner",
    "Ruby", "outcome", "finalist",
  "Zainab", "outcome", "finalist",
    "Emma",  "spices",        "2",
   "Harry",  "spices",        "3",
    "Ruby",  "spices",        "2",
  "Zainab",  "spices",        "0"
  )

juniors_jumbled %>% 
  knitr::kable()

juniors_jumbled %>% 
  pivot_wider(names_from = var_name,
              values_from = var_value)

#' age and spices are characters, but we want numbers instead
juniors_jumbled %>% 
  pivot_wider(names_from = var_name,
              values_from = var_value) %>% 
  mutate_at(vars(age, spices), as.integer)