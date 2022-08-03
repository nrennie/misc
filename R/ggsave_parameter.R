library(ggplot2)

df <- data.frame(x = 1:5, y = 1:5)
p1 <- ggplot(df, aes(x, y)) +
  geom_line()

p2 <- ggplot(df, aes(x, y)) +
  geom_point()

plots <- list(p1, p2)

save_params <- list(
  p1 = list(6, 4, "filename1.jpg"), 
  p2 = list(3, 7, "filename2.jpg")
)

purrr::map2(.x = save_params, 
     .y = plots,
    .f = ~ggsave(plot = .y, 
                 filename = .x[[3]], 
                 width = .x[[2]], 
                 height = .x[[1]], 
                 unit = "cm"))
