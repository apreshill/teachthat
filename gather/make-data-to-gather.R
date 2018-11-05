#' ---
#' output: github_document
#' ---

library(tidyverse)

juniors_untidy <- tribble(
  ~ "baker", ~"cinnamon_1", ~"cardamom_2", ~"nutmeg_3",
  "Emma", 1L,   0L, 1L,
  "Harry", 1L,   1L, 1L,
  "Ruby", 1L,   0L, 1L,
  "Zainab", 0L, NA, 0L
)
juniors_untidy

# way one: select three columns
juniors_untidy %>% 
  gather(key = "spice", value = "correct", cinnamon_1:nutmeg_3)

# way two: "freeze" baker
juniors_untidy %>% 
  gather(key = "spice", value = "correct", -baker)

# way two, this time saving as a new data object
(juniors_tidy <- juniors_untidy %>% 
  gather(key = "spice", value = "correct", -baker))