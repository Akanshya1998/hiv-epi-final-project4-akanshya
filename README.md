# Final Project 4 — Organization & GitHub Repository

**Course:** HIV Epidemiology  
**Student:** Akanshya Dash  
**Repo goal:** Organize code for the Final Project and make a reproducible pipeline to build the final report from data using a Makefile. This repository follows the Part 3 analysis and reproduces the required table and figure via standalone scripts, _not_ inside a single R Markdown file.

---

## Repository structure

```
.
├── Makefile
├── README.md
├── data/
│   └── HIV_Epidemiology_Children_Adolescents_2021.xlsx
├── outputs/
│   ├── table_top10.csv
│   └── global_incidence.png
├── R/
│   ├── 01_setup.R
│   ├── 02_make_table.R        # ← code that creates the required table
│   ├── 03_make_figure.R       # ← code that creates the required figure
│   └── 04_render_report.R
└── report/
    └── final_report.Rmd
```

- **Data** are included in `data/` (fake or truncated data may be substituted if privacy/size requires it).
- The **code for the required table** lives in `R/02_make_table.R` and writes `outputs/table_top10.csv`.
- The **code for the required figure** lives in `R/03_make_figure.R` and writes `outputs/global_incidence.png`.

---

## How to generate the final report (required by rubric)

1. Ensure you have a recent R and the packages in `R/01_setup.R` (the Makefile calls this script).
2. From the repository root, run:

```bash
make all
```

This will:
- install/load packages (`R/01_setup.R`),
- build the table (`R/02_make_table.R` → `outputs/table_top10.csv`),
- build the figure (`R/03_make_figure.R` → `outputs/global_incidence.png`),
- render the final report (`report/final_report.html`).

You can also run steps individually:

```bash
make table     # just (re)make the table
make figure    # just (re)make the figure
make report    # render report after outputs exist
make clean     # remove derived outputs
```

The final report output is: **`report/final_report.html`**.

---

## Notes

- The scripts use only **relative paths**, so the pipeline runs on any machine.
- If you cannot share the real dataset, replace `data/HIV_Epidemiology_Children_Adolescents_2021.xlsx` with a synthetic or truncated version that has the **same columns**.
- Branch should be **`main`** (or `master`) and the repo should be **public** unless otherwise cleared with the instructor.
