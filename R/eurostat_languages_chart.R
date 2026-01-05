library(tidyverse)
library(readxl)
library(ggtext)

raw_data <- read_xlsx("edat_aes_l21$defaultview_page_spreadsheet.xlsx", sheet = 2, skip = 9)

plot_data <- raw_data |>
  select(TIME, `2016`) |>
  rename(region = TIME,
         value = `2016`) |>
  mutate(value = as.numeric(value)) |>
  drop_na() |>
  filter(str_detect(region, "2025", negate = TRUE)) |>
  mutate(
    region = if_else(
      str_detect(region, "European Union"), "EU Average", region
    )
  )

ggplot(data = plot_data) +
  geom_col(
    mapping = aes(x = value, y = reorder(region, value), fill = (region == "EU Average"))
  ) +
  geom_text(
    mapping = aes(x = value, y = reorder(region, value),
                  label = paste0(" ", value, "%")),
    hjust = 0,
    size = 3.5
  ) +
  scale_fill_manual(values = c("#203E5F", "#ffcc00")) +
  scale_x_continuous(limits = c(0, 100)) +
  labs(x = "% of population", y = NULL,
       title = "Over 30% of people report not being able to speak a foreign language",
       subtitle = "Percentage of people aged 25-64 who self-reported as knowing no foreign languages",
       caption = "**Data**: Number of foreign languages known (self-reported) by sex. Eurostat. 2016. DOI: 10.2908/edat_aes_l21<br>**Graphic**: Nicola Rennie. 2026.") +
  coord_cartesian(expand = FALSE) +
  theme_minimal() +
  theme(
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.title = element_textbox_simple(
      colour = "grey5",
      face = "bold",
      hjust = 0,
      halign = 0,
      margin = margin(b = 5, t = 0)
    ),
    plot.subtitle = element_textbox_simple(
      colour = "grey10",
      hjust = 0,
      halign = 0,
      margin = margin(b = 5, t = 0)
    ),
    plot.caption = element_textbox_simple(
      colour = "grey30",
      hjust = 0,
      halign = 0,
      margin = margin(b = 0, t = 10)
    ),
    axis.ticks.y = element_blank(),
    axis.title.x = element_text(hjust = 1),
    legend.position = "none",
    panel.grid.major.y = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("chart.png", width = 5, height = 7, bg = "white")
