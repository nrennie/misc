install.packages("ggh4x")
library(ggh4x)

new_iris <- transform(
  iris, 
  Nester = "Plot title"
)

ggplot(new_iris, aes(Sepal.Width, Sepal.Length)) +
  geom_point() + 
  facet_nested(~ Nester + Species) +
  theme_minimal() +
  theme(strip.background = element_rect(fill = "grey", colour = "white", size = 4), 
        strip.text = element_text(size = 14, margin = margin(t = 10, b = 10)), 
        panel.spacing = unit(2, "lines"))

        