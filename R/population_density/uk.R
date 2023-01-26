#library(R.utils)
#library(tidyverse)
#library(sf)
#library(showtext)
library(ggplot2)
library(rayshader)
library(scico)

options(rgl.useNULL=TRUE)

# load fonts
font_add_google("Poiret One", "poiret")
showtext_auto()

# download data from https://data.humdata.org/dataset/kontur-population-united-kingdom-of-great-britain-and-northern-ireland
# gunzip("R/population_density/kontur_population_GB_20220630.gpkg.gz", remove=FALSE)
kontur <- sf::st_read("R/population_density/kontur_population_GB_20220630.gpkg")

# convert to points
plot_data = kontur |> 
  sf::st_centroid() |> 
  sf::st_coordinates() |> 
  tibble::as_tibble() |> 
  dplyr::mutate(population = kontur$population)

# make ggplot map
g <- ggplot() +
  geom_point(data = plot_data,
             aes(x = X, y = Y, colour = population),
             size = 0.3) +
  scale_color_scico(direction = 1,
                    trans = "pseudo_log",
                    palette = "lajolla",
                    limits = c(0, 18000)) +
  labs(title = "United Kingdom") +
  theme(legend.position = "none",
        plot.title = element_text(colour = "#0B0B45", size = 16, hjust = 0.5),
        plot.margin = margin(10, 20, 10, 20), 
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = "white", colour = "white"),
        panel.background = element_rect(fill = "white", colour = "white")) 
g

# make 3d
rayshader::plot_gg(g, height_aes = "colour")
rayshader::render_snapshot("uk.png", clear = TRUE)
