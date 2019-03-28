pivot\_wider.R
================
alison
2019-03-28

Use the development version of tidyr from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("tidyverse/tidyr")
```

``` r
library(dplyr)
library(tidyr)

juniors_jumbled <- tibble::tribble(
    ~baker, ~var_name, ~var_value,
    "Emma",     "age",       "11",
   "Harry",     "age",       "10",
    "Ruby",     "age",       "11",
  "Zainab",     "age",       "10",
    "Emma", "outcome", "finalist",
   "Harry", "outcome",   "winner",
    "Ruby", "outcome", "finalist",
  "Zainab", "outcome", "finalist",
    "Emma",  "spices",        "2",
   "Harry",  "spices",        "3",
    "Ruby",  "spices",        "2",
  "Zainab",  "spices",        "0"
  )

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
juniors_jumbled %>% 
  pivot_wider(names_from = var_name,
              values_from = var_value)
```

    ## # A tibble: 4 x 4
    ##   baker  age   outcome  spices
    ##   <chr>  <chr> <chr>    <chr> 
    ## 1 Emma   11    finalist 2     
    ## 2 Harry  10    winner   3     
    ## 3 Ruby   11    finalist 2     
    ## 4 Zainab 10    finalist 0

age and spices are characters, but we want numbers instead

``` r
juniors_jumbled %>% 
  pivot_wider(names_from = var_name,
              values_from = var_value) %>% 
  mutate_at(vars(age, spices), as.integer)
```

    ## # A tibble: 4 x 4
    ##   baker    age outcome  spices
    ##   <chr>  <int> <chr>     <int>
    ## 1 Emma      11 finalist      2
    ## 2 Harry     10 winner        3
    ## 3 Ruby      11 finalist      2
    ## 4 Zainab    10 finalist      0
