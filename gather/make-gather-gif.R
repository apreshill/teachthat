library(fs)
library(magick)
library(tidyverse)

list_png <- dir_ls(path = here::here("gather", "gather-gif"),
                   glob = "*.png")

list_png %>% 
  map(image_read) %>% # reads each path file
  image_join() %>% # joins image
  image_animate(fps = .5) %>% # animates, can opt for number of loops
  image_write(here::here("gather", "gather.gif")) # write the gif to file
