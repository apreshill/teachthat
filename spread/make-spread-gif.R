library(fs)
library(magick)
library(tidyverse)

list_png <- dir_ls(path = here::here("spread", "spread-gif"),
                   glob = "*.png")

list_png %>% 
  map(image_read) %>% # reads each path file
  image_join() %>% # joins image
  image_scale("1000") %>% # twitter needs smaller
  image_animate(fps = .5) %>% # animates, can opt for number of loops
  image_write(here::here("spread", "spread.gif")) # write the gif to file
