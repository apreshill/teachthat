#' ---
#' output: github_document
#' ---

library(tidyverse)

juniors_multiple <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", ~ "guess_1", ~"guess_2", ~"guess_3",
  "Emma", 1L,   0L, 1L, "cinnamon",   "cloves", "nutmeg",
  "Harry", 1L,   1L, 1L, "cinnamon",   "cardamom", "nutmeg",
  "Ruby", 1L,   0L, 1L, "cinnamon",   "cumin", "nutmeg",
  "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
)
#' So we have 3 scores and 3 guesses, one for each trial.
#' It would be great scores in 1 column and guesses in another column.
#' Then, we would have 3 rows for baker/trial.
#' That is the goal!
juniors_multiple

#' First gather all 6 columns into one column called `var_value`.
#' Now, this means that temporarily, we just made things less tidy.
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", score_1:guess_3) %>% 
  # we don't need to do this, but it helps to see
  arrange(baker, var_name)

#' We know we need to spread at some point, but we are not there yet.
#' We can't spread by `var_name` because we'll just get the original data set back.
#' We need to `separate` the `var_name` column first into two columns:
#' `var` and `order`.
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("var", "order"), convert = TRUE) %>% 
  # we don't need to do this, but it helps to see
  arrange(baker, var)

#' Almost there! Now we can `spread` to `var_value` column into 2 new columns.
#' One will hold the scores for each trial; the other will hold guesses.
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(score_or_guess, var_value) 

#' Boo- all characters! Convert and name the new tidy data.
(tidy_juniors <- juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(score_or_guess, var_value, convert = TRUE))

#' Although it doesn't make sense here,
#' note that we could have instead spread by the order column.
#' This creates 3 new colums- one for each trial.
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(order, var_value, convert = TRUE)

#' It is annoying to have new column names that are numbers though.
#' `spread` has an argument to fix that: `sep`!
#' Again this isn't tidy, because we have strings and numbers in the same columns.
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(order, var_value, convert = TRUE, sep = "_")
