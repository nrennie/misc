library(ggplot2)
library(plotly)
mtcars$tooltip <- paste0("My custom text: ", mtcars$disp)
g <- ggplot(data = mtcars,
             mapping = aes(x = drat,
                           y = wt,
                           label = tooltip)) +
  geom_point()
gp <- ggplotly(g, tooltip = c("label"))
# to remove the tooltip: at the start
gp$x$data[[1]]$text <- gsub("tooltip: ", "", gp$x$data[[1]]$text)
gp
