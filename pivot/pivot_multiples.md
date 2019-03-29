pivot\_multiples.R
================
alison
2019-03-29

Use the development version of tidyr from GitHub:

``` r
#install.packages("devtools")
#devtools::install_github("tidyverse/tidyr")
```

``` r
library(dplyr)
library(tidyr)

juniors_multiple <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", ~ "guess_1", ~"guess_2", ~"guess_3",
  "Emma", 1L,   0L, 1L, "cinnamon",   "cloves", "nutmeg",
  "Harry", 1L,   1L, 1L, "cinnamon",   "cardamom", "nutmeg",
  "Ruby", 1L,   0L, 1L, "cinnamon",   "cumin", "nutmeg",
  "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
)

juniors_multiple %>% 
  knitr::kable()
```

| baker  | score\_1 | score\_2 | score\_3 | guess\_1 | guess\_2 | guess\_3 |
| :----- | -------: | -------: | -------: | :------- | :------- | :------- |
| Emma   |        1 |        0 |        1 | cinnamon | cloves   | nutmeg   |
| Harry  |        1 |        1 |        1 | cinnamon | cardamom | nutmeg   |
| Ruby   |        1 |        0 |        1 | cinnamon | cumin    | nutmeg   |
| Zainab |        0 |       NA |        0 | cardamom | NA       | cinnamon |

I want three total columns:

  - first is order (1/2/3) –\> these are the numbers at end of my column
    names
  - second is score (0/1/NA)
  - third is guess (cinnamon/cloves/nutmeg/NA)

<!-- end list -->

``` r
juniors_multiple %>% 
  tidyr::pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_"
               )
```

    ## # A tibble: 12 x 4
    ##    baker  order score guess   
    ##    <chr>  <chr> <int> <chr>   
    ##  1 Emma   1         1 cinnamon
    ##  2 Emma   2         0 cloves  
    ##  3 Emma   3         1 nutmeg  
    ##  4 Harry  1         1 cinnamon
    ##  5 Harry  2         1 cardamom
    ##  6 Harry  3         1 nutmeg  
    ##  7 Ruby   1         1 cinnamon
    ##  8 Ruby   2         0 cumin   
    ##  9 Ruby   3         1 nutmeg  
    ## 10 Zainab 1         0 cardamom
    ## 11 Zainab 2        NA <NA>    
    ## 12 Zainab 3         0 cinnamon

order is a character make order a factor

``` r
juniors_multiple %>% 
  pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_",
               col_ptype = list(
                 order = factor(levels = c(1, 2, 3))
                 )
               )
```

    ## # A tibble: 12 x 4
    ##    baker  order score guess   
    ##    <chr>  <fct> <int> <chr>   
    ##  1 Emma   1         1 cinnamon
    ##  2 Emma   2         0 cloves  
    ##  3 Emma   3         1 nutmeg  
    ##  4 Harry  1         1 cinnamon
    ##  5 Harry  2         1 cardamom
    ##  6 Harry  3         1 nutmeg  
    ##  7 Ruby   1         1 cinnamon
    ##  8 Ruby   2         0 cumin   
    ##  9 Ruby   3         1 nutmeg  
    ## 10 Zainab 1         0 cardamom
    ## 11 Zainab 2        NA <NA>    
    ## 12 Zainab 3         0 cinnamon

make order a number instead

``` r
juniors_multiple %>% 
  pivot_longer(-baker,
               names_to = c(".value", "order"),
               names_sep = "_",
               col_ptype = list(
                 order = integer()
                 )
               )
```

    ## # A tibble: 12 x 4
    ##    baker  order score guess   
    ##    <chr>  <int> <int> <chr>   
    ##  1 Emma       1     1 cinnamon
    ##  2 Emma       2     0 cloves  
    ##  3 Emma       3     1 nutmeg  
    ##  4 Harry      1     1 cinnamon
    ##  5 Harry      2     1 cardamom
    ##  6 Harry      3     1 nutmeg  
    ##  7 Ruby       1     1 cinnamon
    ##  8 Ruby       2     0 cumin   
    ##  9 Ruby       3     1 nutmeg  
    ## 10 Zainab     1     0 cardamom
    ## 11 Zainab     2    NA <NA>    
    ## 12 Zainab     3     0 cinnamon
