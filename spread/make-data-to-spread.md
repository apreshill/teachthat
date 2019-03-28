make-data-to-spread.R
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
# we start tidy
juniors_about <- tribble(
  ~ "baker", ~"age", ~"outcome", ~"spices",
  "Emma", 11L, "finalist", 2L, 
  "Harry", 10L, "winner", 3L, 
  "Ruby", 11L, "finalist", 2L, 
  "Zainab", 10L, "finalist", 0L
) 
juniors_about
```

    ## # A tibble: 4 x 4
    ##   baker    age outcome  spices
    ##   <chr>  <int> <chr>     <int>
    ## 1 Emma      11 finalist      2
    ## 2 Harry     10 winner        3
    ## 3 Ruby      11 finalist      2
    ## 4 Zainab    10 finalist      0

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
    ##  9 Emma   spices   2        
    ## 10 Harry  spices   3        
    ## 11 Ruby   spices   2        
    ## 12 Zainab spices   0

``` r
juniors_jumbled %>% 
  knitr::kable()
```

| baker  | var\_name | var\_value |
| :----- | :-------- | :--------- |
| Emma   | age       | 11         |
| Harry  | age       | 10         |
| Ruby   | age       | 11         |
| Zainab | age       | 10         |
| Emma   | outcome   | finalist   |
| Harry  | outcome   | winner     |
| Ruby   | outcome   | finalist   |
| Zainab | outcome   | finalist   |
| Emma   | spices    | 2          |
| Harry  | spices    | 3          |
| Ruby   | spices    | 2          |
| Zainab | spices    | 0          |

``` r
# spread to tidy- but all character variables!
juniors_jumbled %>% 
  spread(var_name, var_value)
```

    ## # A tibble: 4 x 4
    ##   baker  age   outcome  spices
    ##   <chr>  <chr> <chr>    <chr> 
    ## 1 Emma   11    finalist 2     
    ## 2 Harry  10    winner   3     
    ## 3 Ruby   11    finalist 2     
    ## 4 Zainab 10    finalist 0

``` r
# spread to tidy + cast column types too- huzzah!
juniors_jumbled %>% 
  spread(var_name, var_value, convert = TRUE)
```

    ## # A tibble: 4 x 4
    ##   baker    age outcome  spices
    ##   <chr>  <int> <chr>     <int>
    ## 1 Emma      11 finalist      2
    ## 2 Harry     10 winner        3
    ## 3 Ruby      11 finalist      2
    ## 4 Zainab    10 finalist      0
