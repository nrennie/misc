library(ggplot2)
library(gt)

st <- '<p align="justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ac quam sed dui fermentum dictum. Donec aliquet, erat sit amet finibus sollicitudin, diam lacus imperdiet ipsum, sit amet molestie magna dui et risus. Nam consectetur felis vitae ornare sagittis. Suspendisse potenti. Ut est ipsum, gravida vitae fermentum sit amet, vestibulum eget erat. Quisque mattis lacus nec tempus sodales. Mauris vehicula velit vel sapien egestas, at fringilla magna vulputate.</p>'
p <- list(ggplot(mtcars) + geom_point(aes(cyl, disp)))
data.frame(plots = NA) %>%
  gt() %>%
  tab_header(
    title = "My Title",
    subtitle = gt::html(st)
  ) %>%
text_transform(
  locations = cells_body(columns = plots),
  fn = function(x){
    purrr::map(
      p, ggplot_image, height = px(300), aspect_ratio = 1.5
    )
  }
)

