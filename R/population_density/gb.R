library(R.utils)
library(tidyverse)
library(sf)
library(showtext)
library(rayshader)
library(scico)

# load fonts
font_add(family = "Hill House",
         regular = "G:\\My Drive\\GitHub\\misc\\R\\population_density\\Hill_House.otf")
showtext_auto()

# download data from https://data.humdata.org/dataset/kontur-population-united-kingdom-of-great-britain-and-northern-ireland
gunzip("R/population_density/kontur_population_GB_20220630.gpkg.gz", remove=FALSE)
kontur <- st_read("R/population_density/kontur_population_GB_20220630.gpkg")

# make ggplot map
g <- ggplot() +
  geom_sf(data = kontur, 
          aes(fill = population,
              colour = population)) +
  scale_fill_scico(direction = -1, trans = "pseudo_log", palette = "lajolla") +
  scale_color_scico(direction = -1, trans = "pseudo_log", palette = "lajolla") +
  labs(title = "Scotland") +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(colour = "#0B0B45", family = "Hill House", size = 60, hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        plot.background = element_rect(fill = "#fafafa", colour = "#fafafa"),
        panel.background = element_rect(fill = "#fafafa", colour = "#fafafa")) 

# make 3d
rayshader::plot_gg(g,
                   preview = TRUE)
