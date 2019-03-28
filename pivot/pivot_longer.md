pivot\_longer.R
================
alison
2019-03-28

Use the development version of tidyr from GitHub:

``` r
install.packages("devtools")
devtools::install_github("tidyverse/tidyr")
```

``` r
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
```

    ## # A tibble: 4 x 4
    ##   baker  cinnamon_1 cardamom_2 nutmeg_3
    ##   <chr>       <int>      <int>    <int>
    ## 1 Emma            1          0        1
    ## 2 Harry           1          1        1
    ## 3 Ruby            1          0        1
    ## 4 Zainab          0         NA        0

way one: select three columns

``` r
juniors_untidy %>% 
  pivot_longer(cinnamon_1:nutmeg_3,
               names_to = "spice", 
               values_to = "correct")
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Emma   cardamom_2       0
    ##  3 Emma   nutmeg_3         1
    ##  4 Harry  cinnamon_1       1
    ##  5 Harry  cardamom_2       1
    ##  6 Harry  nutmeg_3         1
    ##  7 Ruby   cinnamon_1       1
    ##  8 Ruby   cardamom_2       0
    ##  9 Ruby   nutmeg_3         1
    ## 10 Zainab cinnamon_1       0
    ## 11 Zainab cardamom_2      NA
    ## 12 Zainab nutmeg_3         0

way two: “freeze” baker

``` r
juniors_untidy %>% 
  pivot_longer(-baker,
               names_to = "spice", 
               values_to = "correct")
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Emma   cardamom_2       0
    ##  3 Emma   nutmeg_3         1
    ##  4 Harry  cinnamon_1       1
    ##  5 Harry  cardamom_2       1
    ##  6 Harry  nutmeg_3         1
    ##  7 Ruby   cinnamon_1       1
    ##  8 Ruby   cardamom_2       0
    ##  9 Ruby   nutmeg_3         1
    ## 10 Zainab cinnamon_1       0
    ## 11 Zainab cardamom_2      NA
    ## 12 Zainab nutmeg_3         0

way two, this time saving as a new data object

``` r
(juniors_tidy <- juniors_untidy %>% 
    pivot_longer(-baker,
                 names_to = "spice", 
                 values_to = "correct"))
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Emma   cardamom_2       0
    ##  3 Emma   nutmeg_3         1
    ##  4 Harry  cinnamon_1       1
    ##  5 Harry  cardamom_2       1
    ##  6 Harry  nutmeg_3         1
    ##  7 Ruby   cinnamon_1       1
    ##  8 Ruby   cardamom_2       0
    ##  9 Ruby   nutmeg_3         1
    ## 10 Zainab cinnamon_1       0
    ## 11 Zainab cardamom_2      NA
    ## 12 Zainab nutmeg_3         0

split the current column names into two columns using names\_to +
names\_sep

``` r
juniors_untidy %>% 
  pivot_longer(-baker,
               names_to = c("spice", "order"), 
               names_sep = "_",
               values_to = "correct",
)
```

    ## # A tibble: 12 x 4
    ##    baker  spice    order correct
    ##    <chr>  <chr>    <chr>   <int>
    ##  1 Emma   cinnamon 1           1
    ##  2 Emma   cardamom 2           0
    ##  3 Emma   nutmeg   3           1
    ##  4 Harry  cinnamon 1           1
    ##  5 Harry  cardamom 2           1
    ##  6 Harry  nutmeg   3           1
    ##  7 Ruby   cinnamon 1           1
    ##  8 Ruby   cardamom 2           0
    ##  9 Ruby   nutmeg   3           1
    ## 10 Zainab cinnamon 1           0
    ## 11 Zainab cardamom 2          NA
    ## 12 Zainab nutmeg   3           0
