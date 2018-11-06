make-data-to-spread.R
================
alison
Mon Nov 5 19:18:44 2018

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
# we start tidy
juniors_about <- tribble(
  ~ "baker", ~"age", ~"outcome", ~"correct",
  "Emma", 11L, "finalist", 2L, 
  "Harry", 10L, "winner", 3L, 
  "Ruby", 11L, "finalist", 2L, 
  "Zainab", 10L, "finalist", 0L
) 
juniors_about
```

    ## # A tibble: 4 x 4
    ##   baker    age outcome  correct
    ##   <chr>  <int> <chr>      <int>
    ## 1 Emma      11 finalist       2
    ## 2 Harry     10 winner         3
    ## 3 Ruby      11 finalist       2
    ## 4 Zainab    10 finalist       0

``` r
# we spread to jumble (i.e., make untidy in specific way)
(juniors_jumbled <- juniors_about %>% 
  gather(key = "var_name", value = "var_value", -baker))
```

    ## # A tibble: 12 x 3
    ##    baker  var_name var_value
    ##    <chr>  <chr>    <chr>    
    ##  1 Emma   age      11       
    ##  2 Harry  age      10       
    ##  3 Ruby   age      11       
    ##  4 Zainab age      10       
    ##  5 Emma   outcome  finalist 
    ##  6 Harry  outcome  winner   
    ##  7 Ruby   outcome  finalist 
    ##  8 Zainab outcome  finalist 
    ##  9 Emma   correct  2        
    ## 10 Harry  correct  3        
    ## 11 Ruby   correct  2        
    ## 12 Zainab correct  0

``` r
# spread to tidy- but all character variables!
juniors_jumbled %>% 
  spread(var_name, var_value)
```

    ## # A tibble: 4 x 4
    ##   baker  age   correct outcome 
    ##   <chr>  <chr> <chr>   <chr>   
    ## 1 Emma   11    2       finalist
    ## 2 Harry  10    3       winner  
    ## 3 Ruby   11    2       finalist
    ## 4 Zainab 10    0       finalist

``` r
# spread to tidy + cast column types too- huzzah!
juniors_jumbled %>% 
  spread(var_name, var_value, convert = TRUE)
```

    ## # A tibble: 4 x 4
    ##   baker    age correct outcome 
    ##   <chr>  <int>   <int> <chr>   
    ## 1 Emma      11       2 finalist
    ## 2 Harry     10       3 winner  
    ## 3 Ruby      11       2 finalist
    ## 4 Zainab    10       0 finalist
