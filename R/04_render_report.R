# R/04_render_report.R
args <- commandArgs(trailingOnly = TRUE)
rmd_path <- ifelse(length(args)>=1, args[1], "report/final_report.Rmd")

suppressPackageStartupMessages(library(rmarkdown))

render(input = rmd_path,
       output_format = "html_document",
       output_file   = "final_report.html",
       output_dir    = "report",
       quiet = TRUE)
message("Rendered: report/final_report.html")
