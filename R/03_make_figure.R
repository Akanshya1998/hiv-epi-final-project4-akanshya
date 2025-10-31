# R/03_make_figure.R
args <- commandArgs(trailingOnly = TRUE)
data_path <- ifelse(length(args)>=1, args[1], "data/HIV_Epidemiology_Children_Adolescents_2021.xlsx")
out_png   <- ifelse(length(args)>=2, args[2], "outputs/global_incidence.png")

suppressPackageStartupMessages({
  library(readxl); library(janitor); library(dplyr); library(ggplot2)
})

raw <- read_excel(data_path, sheet = "Data", col_names = TRUE, skip = 1)
expected_names <- c("ISO3","Type","Country/Region","UNICEF Region","Indicator",
                    "Data source","Year","Sex","Age","Value","Lower","Upper")
if (length(names(raw)) >= 12) names(raw)[1:12] <- expected_names
dat <- clean_names(raw)

numfix <- function(x) suppressWarnings(as.numeric(gsub("[^0-9.]", "", as.character(x))))
dat <- dat |>
  mutate(
    year = as.integer(year),
    value = numfix(value)
  )

inc_pat <- "(?i)incidence rate"

global_trend <- dat |>
  filter(grepl(inc_pat, indicator),
         age == "Age 10-19",
         sex == "Both",
         country_region == "Global",
         !is.na(year), !is.na(value)) |>
  arrange(year)

p <- ggplot(global_trend, aes(x = year, y = value)) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2) +
  labs(title   = "Global Adolescent (10–19) HIV Incidence Rate, 2000–2020",
       x = "Year",
       y = "Incidence per 1,000 uninfected population",
       caption = "Source: UNICEF/UNAIDS 2021 estimates") +
  theme_minimal(base_size = 13)

dir.create(dirname(out_png), showWarnings = FALSE, recursive = TRUE)
ggsave(out_png, plot = p, width = 8, height = 5, dpi = 300)
message("Wrote: ", out_png)
