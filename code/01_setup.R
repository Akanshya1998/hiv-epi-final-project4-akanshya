# Anchor for here()
here::i_am("code/01_setup.R")

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(readxl)
  library(here)
})

# --- helper: detect the header row dynamically --------------------------------
.detect_header_skip <- function(path) {
  # Peek first 40 rows with no header
  peek <- readxl::read_excel(path, col_names = FALSE, n_max = 40)
  
  # A row is a header if it has >=5 non-empty cells AND contains the expected fields
  header_rows <- which(apply(peek, 1, function(r) {
    filled <- sum(!is.na(r) & nzchar(as.character(r)))
    filled >= 5 &&
      any(grepl("country|region", r, ignore.case = TRUE), na.rm = TRUE) &&
      any(grepl("^year$",         r, ignore.case = TRUE), na.rm = TRUE) &&
      any(grepl("^age",           r, ignore.case = TRUE), na.rm = TRUE) &&
      any(grepl("indicator",      r, ignore.case = TRUE), na.rm = TRUE) &&
      any(grepl("^value",         r, ignore.case = TRUE), na.rm = TRUE)
  }))
  
  if (length(header_rows) == 0) {
    # Fallback that worked in your interactive tries
    return(9L)
  } else {
    return(as.integer(header_rows[1] - 1L))
  }
}

# ---- Load dataset function ----
load_data <- function() {
  path <- here::here("data", "HIV_Epidemiology_Children_Adolescents_2021.xlsx")
  
  # try a few likely header positions; pick the first that yields >=5 columns
  for (sk in c(9, 10, 11, 12)) {
    dat <- try(readxl::read_excel(path, skip = sk, .name_repair = "minimal"),
               silent = TRUE)
    if (!inherits(dat, "try-error") && ncol(dat) >= 5) {
      # keep first 5 columns and standardize names
      dat <- dat[, 1:5, drop = FALSE]
      nm <- names(dat)
      names(dat)[match(TRUE, grepl("country|region", nm, ignore.case=TRUE))] <- "country_region"
      names(dat)[match(TRUE, grepl("^year$",        nm, ignore.case=TRUE))] <- "year"
      names(dat)[match(TRUE, grepl("^age",          nm, ignore.case=TRUE))] <- "age"
      names(dat)[match(TRUE, grepl("indicator",     nm, ignore.case=TRUE))] <- "indicator"
      names(dat)[match(TRUE, grepl("^value",        nm, ignore.case=TRUE))] <- "value"
      
      dat$year  <- suppressWarnings(as.integer(dat$year))
      dat$value <- suppressWarnings(readr::parse_number(as.character(dat$value)))
      
      assign("name_col", "country_region", envir = .GlobalEnv)
      assign("year_col", "year",           envir = .GlobalEnv)
      assign("age_col",  "age",            envir = .GlobalEnv)
      assign("ind_col",  "indicator",      envir = .GlobalEnv)
      assign("val_col",  "value",          envir = .GlobalEnv)
      
      message("✅ Data loaded (skip = ", sk, ")")
      return(dat)
    }
  }
  stop("Could not locate a header row with >= 5 non-empty cells after trying skips 9–12.")
}

# Filters used downstream
inc_name <- "Estimated incidence rate (new HIV infection per 1,000 uninfected population)"
ages <- "Age 10-19"

coerce_value_numeric <- function(dat) {
  if (!is.numeric(dat[[val_col]])) {
    dat[[val_col]] <- suppressWarnings(readr::parse_number(dat[[val_col]]))
  }
  dat
}