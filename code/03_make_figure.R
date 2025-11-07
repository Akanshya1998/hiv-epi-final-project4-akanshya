here::i_am("code/03_make_figure.R")

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(here)
})

source(here("code", "01_setup.R"))
raw <- load_data() |> coerce_value_numeric()

trend <- raw |>
  filter(.data[[age_col]] == ages,
         .data[[ind_col]] == inc_name) |>
  group_by(Year = .data[[year_col]]) |>
  summarise(Incidence = mean(.data[[val_col]], na.rm = TRUE), .groups = "drop") |>
  arrange(Year)

p <- ggplot(trend, aes(x = Year, y = Incidence)) +
  geom_line() + geom_point() +
  labs(title = "Global adolescent HIV incidence (10–19)",
       x = "Year", y = "Incidence rate (per 1,000 uninfected)") +
  theme_minimal()

dir.create(here("output","figures"), recursive = TRUE, showWarnings = FALSE)
ggsave(here("output","figures","global_adol_inc_trend.png"),
       plot = p, width = 8, height = 5, dpi = 300)
message("Saved: output/figures/global_adol_inc_trend.png")
