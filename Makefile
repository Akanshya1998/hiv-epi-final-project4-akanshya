# Makefile for Final Project 4 (Akanshya Dash)

R=Rscript
DATA=data/HIV_Epidemiology_Children_Adolescents_2021.xlsx
OUTDIR=outputs
TABLE=$(OUTDIR)/table_top10.csv
FIG=$(OUTDIR)/global_incidence.png
REPORT_RMD=report/final_report.Rmd
REPORT_HTML=report/final_report.html

.PHONY: all setup data table figure report clean

all: setup table figure report

setup:
	$(R) R/01_setup.R

data:
	@echo "Data expected at $(DATA). Replace with a fake/truncated copy if needed."

$(TABLE): $(DATA) R/02_make_table.R
	$(R) R/02_make_table.R $(DATA) $(TABLE)

$(FIG): $(DATA) R/03_make_figure.R
	$(R) R/03_make_figure.R $(DATA) $(FIG)

report: $(TABLE) $(FIG) $(REPORT_RMD) R/04_render_report.R
	$(R) R/04_render_report.R $(REPORT_RMD)

clean:
	rm -f $(TABLE) $(FIG) $(REPORT_HTML)
