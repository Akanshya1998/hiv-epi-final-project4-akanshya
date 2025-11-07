# Build everything by default
all: report/report.html

# Final report depends on the figure, table, and Rmd
report/report.html: output/figures/global_adol_inc_trend.png \
                    output/tables/top10_adol_inc_2020.csv \
                    report/final_report.Rmd
	Rscript -e "rmarkdown::render('report/final_report.Rmd', output_file='report.html', output_dir='report')"

# Table depends on the raw Excel + table code
output/tables/top10_adol_inc_2020.csv: data/HIV_Epidemiology_Children_Adolescents_2021.xlsx \
                                       code/01_setup.R code/02_make_table.R
	Rscript code/02_make_table.R

# Figure depends on the raw Excel + figure code
output/figures/global_adol_inc_trend.png: data/HIV_Epidemiology_Children_Adolescents_2021.xlsx \
                                          code/01_setup.R code/03_make_figure.R
	Rscript code/03_make_figure.R

.PHONY: clean
clean:
	rm -f output/tables/*.csv output/figures/*.png report/*.html