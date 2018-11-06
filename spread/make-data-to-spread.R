#' ---
#' output: github_document
#' ---

library(tidyverse)

# we start tidy
juniors_about <- tribble(
  ~ "baker", ~"age", ~"outcome", ~"spices",
  "Emma", 11L, "finalist", 2L, 
  "Harry", 10L, "winner", 3L, 
  "Ruby", 11L, "finalist", 2L, 
  "Zainab", 10L, "finalist", 0L
) 
juniors_about

# we spread to jumble (i.e., make untidy in specific way)
(juniors_jumbled <- juniors_about %>% 
  gather(key = "var_name", value = "var_value", -baker))

# spread to tidy- but all character variables!
juniors_jumbled %>% 
  spread(var_name, var_value)

# spread to tidy + cast column types too- huzzah!
juniors_jumbled %>% 
  spread(var_name, var_value, convert = TRUE)

