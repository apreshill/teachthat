make-multiples-to-gather.R
================
alison
2019-03-28

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0.9000     ✔ purrr   0.3.2.9000
    ## ✔ tibble  2.1.1          ✔ dplyr   0.8.0.9010
    ## ✔ tidyr   0.8.3.9000     ✔ stringr 1.4.0     
    ## ✔ readr   1.3.1          ✔ forcats 0.4.0

    ## Warning: package 'forcats' was built under R version 3.5.2

    ## ── Conflicts ────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
juniors_multiple <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", ~ "guess_1", ~"guess_2", ~"guess_3",
  "Emma", 1L,   0L, 1L, "cinnamon",   "cloves", "nutmeg",
  "Harry", 1L,   1L, 1L, "cinnamon",   "cardamom", "nutmeg",
  "Ruby", 1L,   0L, 1L, "cinnamon",   "cumin", "nutmeg",
  "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
)
```

So we have 3 scores and 3 guesses, one for each trial. It would be great
scores in 1 column and guesses in another column. Then, we would have 3
rows for baker/trial. That is the goal\!

``` r
juniors_multiple
```

    ## # A tibble: 4 x 7
    ##   baker  score_1 score_2 score_3 guess_1  guess_2  guess_3 
    ##   <chr>    <int>   <int>   <int> <chr>    <chr>    <chr>   
    ## 1 Emma         1       0       1 cinnamon cloves   nutmeg  
    ## 2 Harry        1       1       1 cinnamon cardamom nutmeg  
    ## 3 Ruby         1       0       1 cinnamon cumin    nutmeg  
    ## 4 Zainab       0      NA       0 cardamom <NA>     cinnamon

First gather all 6 columns into one column called `var_value`. Now, this
means that temporarily, we just made things less tidy.

``` r
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", score_1:guess_3) %>% 
  # we don't need to do this, but it helps to see
  arrange(baker, var_name)
```

    ## # A tibble: 24 x 3
    ##    baker var_name var_value
    ##    <chr> <chr>    <chr>    
    ##  1 Emma  guess_1  cinnamon 
    ##  2 Emma  guess_2  cloves   
    ##  3 Emma  guess_3  nutmeg   
    ##  4 Emma  score_1  1        
    ##  5 Emma  score_2  0        
    ##  6 Emma  score_3  1        
    ##  7 Harry guess_1  cinnamon 
    ##  8 Harry guess_2  cardamom 
    ##  9 Harry guess_3  nutmeg   
    ## 10 Harry score_1  1        
    ## # … with 14 more rows

We know we need to spread at some point, but we are not there yet. We
can’t spread by `var_name` because we’ll just get the original data set
back. We need to `separate` the `var_name` column first into two
columns: `var` and `order`.

``` r
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("var", "order"), convert = TRUE) %>% 
  # we don't need to do this, but it helps to see
  arrange(baker, var)
```

    ## # A tibble: 24 x 4
    ##    baker var   order var_value
    ##    <chr> <chr> <int> <chr>    
    ##  1 Emma  guess     1 cinnamon 
    ##  2 Emma  guess     2 cloves   
    ##  3 Emma  guess     3 nutmeg   
    ##  4 Emma  score     1 1        
    ##  5 Emma  score     2 0        
    ##  6 Emma  score     3 1        
    ##  7 Harry guess     1 cinnamon 
    ##  8 Harry guess     2 cardamom 
    ##  9 Harry guess     3 nutmeg   
    ## 10 Harry score     1 1        
    ## # … with 14 more rows

Almost there\! Now we can `spread` to `var_value` column into 2 new
columns. One will hold the scores for each trial; the other will hold
guesses.

``` r
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(score_or_guess, var_value) 
```

    ## # A tibble: 12 x 4
    ##    baker  order guess    score
    ##    <chr>  <int> <chr>    <chr>
    ##  1 Emma       1 cinnamon 1    
    ##  2 Emma       2 cloves   0    
    ##  3 Emma       3 nutmeg   1    
    ##  4 Harry      1 cinnamon 1    
    ##  5 Harry      2 cardamom 1    
    ##  6 Harry      3 nutmeg   1    
    ##  7 Ruby       1 cinnamon 1    
    ##  8 Ruby       2 cumin    0    
    ##  9 Ruby       3 nutmeg   1    
    ## 10 Zainab     1 cardamom 0    
    ## 11 Zainab     2 <NA>     <NA> 
    ## 12 Zainab     3 cinnamon 0

Boo- all characters\! Convert and name the new tidy data.

``` r
(tidy_juniors <- juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(score_or_guess, var_value, convert = TRUE))
```

    ## # A tibble: 12 x 4
    ##    baker  order guess    score
    ##    <chr>  <int> <chr>    <int>
    ##  1 Emma       1 cinnamon     1
    ##  2 Emma       2 cloves       0
    ##  3 Emma       3 nutmeg       1
    ##  4 Harry      1 cinnamon     1
    ##  5 Harry      2 cardamom     1
    ##  6 Harry      3 nutmeg       1
    ##  7 Ruby       1 cinnamon     1
    ##  8 Ruby       2 cumin        0
    ##  9 Ruby       3 nutmeg       1
    ## 10 Zainab     1 cardamom     0
    ## 11 Zainab     2 <NA>        NA
    ## 12 Zainab     3 cinnamon     0

Although it doesn’t make sense here, note that we could have instead
spread by the order column. This creates 3 new colums- one for each
trial.

``` r
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(order, var_value, convert = TRUE)
```

    ## # A tibble: 8 x 5
    ##   baker  score_or_guess `1`      `2`      `3`     
    ##   <chr>  <chr>          <chr>    <chr>    <chr>   
    ## 1 Emma   guess          cinnamon cloves   nutmeg  
    ## 2 Emma   score          1        0        1       
    ## 3 Harry  guess          cinnamon cardamom nutmeg  
    ## 4 Harry  score          1        1        1       
    ## 5 Ruby   guess          cinnamon cumin    nutmeg  
    ## 6 Ruby   score          1        0        1       
    ## 7 Zainab guess          cardamom <NA>     cinnamon
    ## 8 Zainab score          0        <NA>     0

It is annoying to have new column names that are numbers though.
`spread` has an argument to fix that: `sep`\! Again this isn’t tidy,
because we have strings and numbers in the same columns.

``` r
juniors_multiple %>% 
  gather(key = "var_name", value = "var_value", -baker) %>% 
  separate(var_name, into = c("score_or_guess", "order"), convert = TRUE) %>% 
  spread(order, var_value, convert = TRUE, sep = "_")
```

    ## # A tibble: 8 x 5
    ##   baker  score_or_guess order_1  order_2  order_3 
    ##   <chr>  <chr>          <chr>    <chr>    <chr>   
    ## 1 Emma   guess          cinnamon cloves   nutmeg  
    ## 2 Emma   score          1        0        1       
    ## 3 Harry  guess          cinnamon cardamom nutmeg  
    ## 4 Harry  score          1        1        1       
    ## 5 Ruby   guess          cinnamon cumin    nutmeg  
    ## 6 Ruby   score          1        0        1       
    ## 7 Zainab guess          cardamom <NA>     cinnamon
    ## 8 Zainab score          0        <NA>     0
