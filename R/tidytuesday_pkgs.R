library(tidyverse)
library(NCmisc)
library(ggwordcloud)

setwd("G:/My Drive/GitHub/tidytuesday")
rscripts2021 = list.files("2021/", pattern = ".R$", recursive = TRUE)

# function to extract functions
get_functions <- function(file){
  file1 = glue::glue("G:\\My Drive\\GitHub\\tidytuesday\\2021\\{file}")
  functions = list.functions.in.file(file1)
  functions = unname(unlist(functions))
  return(functions)
}
# test
get_functions(rscripts2021[1])

# map over all files
all_functions = purrr::map(.x = rscripts2021, 
                           .f = ~get_functions(.x))
all_functions_c = unlist(all_functions)

# count usage
plot_data <- tibble(functions = all_functions_c) %>% 
  group_by(functions) %>% 
  summarise(n = n()) %>% 
  arrange(-n)
plot_data

# create word cloud
dev.new(width = 12, height = 12, unit = "in", noRStudioGD = TRUE)
set.seed(42)
ggplot(data = plot_data, 
       mapping = aes(label = functions, size = n, colour = n)) +
  geom_text_wordcloud(shape = "square") +
  scale_size_area(max_size = 12) +
  scale_colour_distiller(palette = "PRGn") +
  theme_void() 











