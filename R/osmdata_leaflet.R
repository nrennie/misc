library(tidyverse)
library(osmdata)
library(sf)
library(leaflet)

#choose area
bbx <- getbb("Newcastle, UK")

# large roads
roads <- bbx %>%
  opq() %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "trunk", "primary")) %>%
  osmdata_sf()

# boundaries
all_boundaries <- opq(bbx) %>%
  add_osm_feature(key = "boundary", 
                  value = c("administrative")) %>%
  osmdata_sf()

# map with leaflet
leaflet() %>%
  addTiles() %>% 
  addPolygons(data = all_boundaries$osm_polygons[7,], fillColor = "red") %>% 
  addPolylines(data = roads$osm_line, weight = 1.5, label = roads$osm_line$osm_id)


# Crop polygon by line ----------------------------------------------------


# make a polygon
polygon1 <- st_polygon(list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))))
plot(polygon1)
# create a line that intersects it
line1 <- st_linestring(matrix(c(0.5, 1.2, 0, 0.5), nrow = 2))
lines(line1)

cropped_sf <- lwgeom::st_split(polygon1, line1) %>% 
  st_collection_extract(c("POLYGON"))
plot(cropped_sf[1])






