# HIV Epidemiology – Children & Adolescents (DATA 550 Final Project 4)
Author: Akanshya Dash

This repo reproduces a small analysis using the UNAIDS HIV epidemiology indicators for children/adolescents.

## Data
- **File:** `data/HIV_Epidemiology_Children_Adolescents_2021.xlsx`
- **Source:** UNAIDS 2021 estimates
- **Indicators used in this project:**
  - *Estimated incidence rate (new HIV infection per 1,000 uninfected population)*
- **Age group filtered:** 10–19 years

## Outputs
- **Table**: `output/tables/top10_adol_inc_2020.csv`  
  Top 10 countries/regions by adolescent (10–19) HIV incidence in 2020.
- **Figure**: `output/figures/global_adol_inc_trend.png`  
  Global adolescent (10–19) HIV incidence trend over time.
- **Report**: `report/report.html`

## Code Description
- `code/01_setup.R`  
  Loads libraries, reads Excel (skipping front matter), standardizes column names, and exposes helper functions.
- `code/02_make_table.R`  
  Filters for age **10–19** + incidence indicator for 2020, saves the **top10** CSV.
- `code/03_make_figure.R`  
  Aggregates the same indicator across years and saves the **trend** PNG.

## How to Reproduce

### Option A — Make
From the project root:
```bash
make all