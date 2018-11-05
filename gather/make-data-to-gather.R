library(tibble)
juniors_untidy <- tribble(
  ~ "baker", ~"cinnamon_1", ~"cardamom_2", ~"nutmeg_3",
  "Emma", 1L,   0L, 1L,
  "Harry", 1L,   1L, 1L,
  "Ruby", 1L,   0L, 1L,
  "Zainab", 0L, NA, 0L
)
juniors_untidy

juniors_tidy <- juniors_untidy %>% 
  gather(key = "spice", value = "correct", cinnamon_1:nutmeg_3)