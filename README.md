# Qiwen Bian — MUSA 5080 Portfolio

This repository contains my coursework for **MUSA 5080: Public Policy
Analytics** at the University of Pennsylvania.

**Live portfolio:** <https://rowen37.github.io/MUSA-5080-portfolio/>

## About the portfolio

The portfolio documents my work with public-policy and spatial data in R. It
includes weekly learning notes, reproducible assignments, maps, statistical
models, and reflections on how analytical choices affect policy conclusions.

Topics covered so far include:

- American Community Survey data and margins of error
- Data manipulation and visualization with `dplyr` and `ggplot2`
- Spatial data, coordinate reference systems, joins, buffers, and distances
- Regression, cross-validation, feature engineering, and residual diagnostics
- Moran's I, LISA, and spatial patterns in model error
- Fairness, data leakage, and responsible use of predictive models

## Repository structure

```text
index.qmd          Portfolio homepage
about.qmd          Background and contact information
weekly-notes/      Weekly course notes
assignments/       Course assignments and supporting data
practice/          In-class practice files
_quarto.yml        Quarto website configuration
docs/              Rendered website published with GitHub Pages
```

## Build the site

Open the project in RStudio and use **Render Website**, or run:

```bash
quarto render
```

Quarto writes the generated website to `docs/`. GitHub Pages publishes the
site from that directory.

## Tools

R, Quarto, Git, `tidyverse`, `tidycensus`, `sf`, `caret`, and `spdep`.
