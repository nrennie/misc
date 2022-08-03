#test theme idea

reset_gg <- function() {
  update_geom_defaults("col", list(fill = "gray"))
}

theme_gg <- function() {
  update_geom_defaults("col", list(fill = "red"))
}

theme_gg2 <- function() {
  update_geom_defaults("col", list(fill = "red"))
  on.exit(reset_gg(), add = TRUE, after = FALSE)
}

theme_gg3 <- function() {
  Sys.sleep(3)
  on.exit(reset_gg(), add = TRUE)
}

ggplot(data, aes(x=x, y=y))+
  geom_col() +
  theme_gg3()


library(ggplot2)
data <- data.frame(x=c("A", "B", "C"), 
                   y=c(1, 2, 3))

ggplot(data, aes(x=x, y=y))+
  geom_col() +
  theme_gg()

reset_gg()

ggplot(data, aes(x=x, y=y))+
  geom_col()

#
ggplot(data, aes(x=x, y=y))+
  geom_col() +
  theme_gg2()

ggplot(data, aes(x=x, y=y))+
  geom_col()



