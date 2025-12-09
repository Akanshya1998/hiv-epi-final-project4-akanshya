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
- **Report**: `output/final_report.html`

## Code Description
- `code/01_setup.R`  
  Loads libraries, reads Excel (skipping front matter), standardizes column names, and exposes helper functions.
- `code/02_make_table.R`  
  Filters for age **10–19** + incidence indicator for 2020, saves the **top10** CSV.
- `code/03_make_figure.R`  
  Aggregates the same indicator across years and saves the **trend** PNG.
- `report/final_report.Rmd`  
  R Markdown report that generates the final HTML output with tables and figures.

## How to Reproduce

### Option 1: Using Docker (Recommended for Full Reproducibility)

This is the easiest and most reproducible method, as it runs the entire analysis in a containerized environment.

#### Building the Docker Image

To build the Docker image locally:

```bash
docker build -t akanshya1998/hiv-report:latest .
```

#### Using the Pre-built DockerHub Image

The Docker image is publicly available on DockerHub:

**Image:** `akanshya1998/hiv-report:latest`

**Link:** https://hub.docker.com/r/akanshya1998/hiv-report

To pull the image:

```bash
docker pull akanshya1998/hiv-report:latest
```

#### Generating the Report

**Using Make (Easiest):**

```bash
make report
```

This will automatically run the Docker container and generate all outputs in the `output/` directory.

**Manual Docker Run:**

On Mac/Linux:
```bash
docker run --rm -v "$(pwd)/output":/project/output akanshya1998/hiv-report:latest
```

On Windows (Git Bash):
```bash
docker run --rm -v "/$(pwd)/output":/project/output akanshya1998/hiv-report:latest
```

**What Gets Generated:**
- `output/final_report.html` - The compiled HTML report
- `output/tables/top10_adol_inc_2020.csv` - Top 10 countries table
- `output/figures/global_adol_inc_trend.png` - Global trend visualization

### Option 2: Local R Environment (Using renv)

If you prefer to run the analysis locally without Docker:

1. Clone this repository and open the RStudio project file `Final_Project_part4.Rproj`.
2. In the R console, run (only needed the first time on a new computer):

```r
install.packages("renv")   # if renv is not already installed
renv::restore()            # installs the packages listed in renv.lock
```

3. Render the report:

```r
rmarkdown::render("report/final_report.Rmd")
```

## Project Structure

```
.
├── Dockerfile                           # Docker configuration for reproducibility
├── Makefile                             # Automation for building and running
├── README.md                            # This file
├── Final_Project_part4.Rproj           # RStudio project file
├── renv.lock                           # R package dependencies
├── .dockerignore                       # Files to exclude from Docker build
├── data/                               # Raw data files
│   └── HIV_Epidemiology_Children_Adolescents_2021.xlsx
├── code/                               # Analysis scripts
│   ├── 01_setup.R
│   ├── 02_make_table.R
│   └── 03_make_figure.R
├── report/                             # R Markdown report
│   └── final_report.Rmd
├── renv/                               # renv package cache
└── output/                             # Generated outputs
    ├── final_report.html
    ├── tables/
    │   └── top10_adol_inc_2020.csv
    └── figures/
        └── global_adol_inc_trend.png
```

## Requirements

### For Docker Method:
- Docker installed and running

### For Local Method:
- R (version 4.3.0 or compatible)
- RStudio (optional but recommended)
- Required R packages (automatically installed via `renv::restore()`)