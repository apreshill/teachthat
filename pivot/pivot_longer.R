#' ---
#' output: github_document
#' ---

#' Use the development version of tidyr from GitHub:
#+ devversion, eval = FALSE
install.packages("devtools")
devtools::install_github("tidyverse/tidyr")

#+ packages, warning = FALSE, message = FALSE
library(dplyr)
library(tidyr)

juniors_untidy <- tribble(
  ~ "baker", ~"cinnamon_1", ~"cardamom_2", ~"nutmeg_3",
  "Emma", 1L,   0L, 1L,
  "Harry", 1L,   1L, 1L,
  "Ruby", 1L,   0L, 1L,
  "Zainab", 0L, NA, 0L
)
juniors_untidy

#' way one: select three columns
juniors_untidy %>% 
  pivot_longer(cinnamon_1:nutmeg_3,
               names_to = "spice", 
               values_to = "correct")

#' way two: "freeze" baker
juniors_untidy %>% 
  pivot_longer(-baker,
               names_to = "spice", 
               values_to = "correct")

#' way two, this time saving as a new data object
(juniors_tidy <- juniors_untidy %>% 
    pivot_longer(-baker,
                 names_to = "spice", 
                 values_to = "correct"))

#' split the current column names into two columns using names_to + names_sep
juniors_untidy %>% 
  pivot_longer(-baker,
               names_to = c("spice", "order"), 
               names_sep = "_",
               values_to = "correct",
)