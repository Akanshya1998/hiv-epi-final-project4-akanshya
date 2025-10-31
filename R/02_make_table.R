# R/02_make_table.R
args <- commandArgs(trailingOnly = TRUE)
data_path <- ifelse(length(args)>=1, args[1], "data/HIV_Epidemiology_Children_Adolescents_2021.xlsx")
out_csv   <- ifelse(length(args)>=2, args[2], "outputs/table_top10.csv")

suppressPackageStartupMessages({
  library(readxl); library(janitor); library(dplyr); library(readr)
})

# read + clean (skip first title row)
raw <- read_excel(data_path, sheet = "Data", col_names = TRUE, skip = 1)

expected_names <- c("ISO3","Type","Country/Region","UNICEF Region","Indicator",
                    "Data source","Year","Sex","Age","Value","Lower","Upper")
if (length(names(raw)) >= 12) names(raw)[1:12] <- expected_names

dat <- clean_names(raw)

numfix <- function(x) suppressWarnings(as.numeric(gsub("[^0-9.]", "", as.character(x))))
dat <- dat |>
  mutate(
    year = as.integer(year),
    value = numfix(value),
    lower = numfix(lower),
    upper = numfix(upper)
  )

inc_pat <- "(?i)incidence rate"

tbl_2020 <- dat |>
  filter(grepl(inc_pat, indicator),
         age == "Age 10-19",
         sex == "Both",
         type == "Country",
         year == 2020,
         !is.na(value)) |>
  arrange(desc(value)) |>
  select(country = country_region, year,
         incidence_per_1000 = value, lower, upper) |>
  slice(1:10)

dir.create(dirname(out_csv), showWarnings = FALSE, recursive = TRUE)
write_csv(tbl_2020, out_csv)
message("Wrote: ", out_csv)
