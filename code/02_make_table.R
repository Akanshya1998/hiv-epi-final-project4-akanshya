here::i_am("code/02_make_table.R")

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(here)
})

source(here("code", "01_setup.R"))
dat <- load_data() |> coerce_value_numeric()

tbl <- dat |>
  filter(.data[[age_col]] == ages,
         .data[[ind_col]] == inc_name,
         .data[[year_col]] == 2020) |>
  arrange(desc(.data[[val_col]])) |>
  slice_head(n = 10) |>
  select(country_region = .data[[name_col]],
         incidence_2020 = .data[[val_col]])

dir.create(here("output", "tables"), recursive = TRUE, showWarnings = FALSE)
write_csv(tbl, here("output", "tables", "top10_adol_inc_2020.csv"))
message("Saved: output/tables/top10_adol_inc_2020.csv")
