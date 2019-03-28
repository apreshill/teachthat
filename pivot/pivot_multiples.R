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

juniors_multiple <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", ~ "guess_1", ~"guess_2", ~"guess_3",
  "Emma", 1L,   0L, 1L, "cinnamon",   "cloves", "nutmeg",
  "Harry", 1L,   1L, 1L, "cinnamon",   "cardamom", "nutmeg",
  "Ruby", 1L,   0L, 1L, "cinnamon",   "cumin", "nutmeg",
  "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
)

juniors_multiple %>% 
  knitr::kable()

#' I want three total columns:
#' 
#' + first is order (1/2/3) --> these are the numbers at end of my column names
#' + second is score (0/1/NA)
#' + third is guess (cinnamon/cloves/nutmeg/NA)
juniors_multiple %>% 
  pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_"
               )

#' order is a character
#' make order a factor
juniors_multiple %>% 
  pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_",
               col_ptype = list(
                 order = factor(levels = c(1, 2, 3))
                 )
               )

#' make order a number instead
juniors_multiple %>% 
  pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_",
               col_ptype = list(
                 order = integer()
                 )
               )
               
    
