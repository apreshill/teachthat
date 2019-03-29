library(fs)
library(magick)
library(tidyverse)

list_png1 <- dir_ls(path = here::here("pivot", "pivot_longer"),
                   glob = "*.png") %>% 
  enframe() %>% 
  mutate(slide_num = str_pad(parse_number(path_file(value)), width = 2, pad = "0"),
         new_path = glue::glue("{path_dir(value)}/Slide{slide_num}.png")) %>% 
  arrange(slide_num)

file_move(path = list_png1$value, new_path = list_png1$new_path)

list_png <- dir_ls(path = here::here("pivot", "pivot_longer"),
                   glob = "*.png")

for_gif <- list_png %>% 
  map(image_read) %>% # reads each path file
  image_join() # joins image
  

for_gif %>% 
  image_scale("800") %>% 
  image_animate(fps = .5) %>% # animates, can opt for number of loops
  image_write(here::here("pivot", "pivot_longer_smaller.gif")) # write the gif to file

for_gif %>% 
  image_scale("2000") %>% 
  image_animate(fps = .5) %>% # animates, can opt for number of loops
  image_write(here::here("pivot", "pivot_longer_larger.gif")) # write the gif to file
