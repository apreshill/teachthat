make-data-to-gather.R
================
alison
Mon Nov 5 14:43:23 2018

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0     ✔ purrr   0.2.5
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.6
    ## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ───────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
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

``` r
# way one: select three columns
juniors_untidy %>% 
  gather(key = "spice", value = "correct", cinnamon_1:nutmeg_3)
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Harry  cinnamon_1       1
    ##  3 Ruby   cinnamon_1       1
    ##  4 Zainab cinnamon_1       0
    ##  5 Emma   cardamom_2       0
    ##  6 Harry  cardamom_2       1
    ##  7 Ruby   cardamom_2       0
    ##  8 Zainab cardamom_2      NA
    ##  9 Emma   nutmeg_3         1
    ## 10 Harry  nutmeg_3         1
    ## 11 Ruby   nutmeg_3         1
    ## 12 Zainab nutmeg_3         0

``` r
# way two: "freeze" baker
juniors_untidy %>% 
  gather(key = "spice", value = "correct", -baker)
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Harry  cinnamon_1       1
    ##  3 Ruby   cinnamon_1       1
    ##  4 Zainab cinnamon_1       0
    ##  5 Emma   cardamom_2       0
    ##  6 Harry  cardamom_2       1
    ##  7 Ruby   cardamom_2       0
    ##  8 Zainab cardamom_2      NA
    ##  9 Emma   nutmeg_3         1
    ## 10 Harry  nutmeg_3         1
    ## 11 Ruby   nutmeg_3         1
    ## 12 Zainab nutmeg_3         0

``` r
# way two, this time saving as a new data object
(juniors_tidy <- juniors_untidy %>% 
  gather(key = "spice", value = "correct", -baker))
```

    ## # A tibble: 12 x 3
    ##    baker  spice      correct
    ##    <chr>  <chr>        <int>
    ##  1 Emma   cinnamon_1       1
    ##  2 Harry  cinnamon_1       1
    ##  3 Ruby   cinnamon_1       1
    ##  4 Zainab cinnamon_1       0
    ##  5 Emma   cardamom_2       0
    ##  6 Harry  cardamom_2       1
    ##  7 Ruby   cardamom_2       0
    ##  8 Zainab cardamom_2      NA
    ##  9 Emma   nutmeg_3         1
    ## 10 Harry  nutmeg_3         1
    ## 11 Ruby   nutmeg_3         1
    ## 12 Zainab nutmeg_3         0
