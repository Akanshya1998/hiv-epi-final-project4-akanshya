# R/01_setup.R
pkgs <- c("readxl","janitor","dplyr","ggplot2","knitr","readr","rmarkdown")
to_install <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(to_install)) install.packages(to_install, repos = "https://cloud.r-project.org")
invisible(lapply(pkgs, library, character.only = TRUE))
message("Packages ready.")