
<!-- README.md is generated from README.Rmd. Please edit that file -->

# quanyu

**quanyu** is an R package developed for **ETC5523 Assignment 4**.  
It provides a small demo dataset and a Shiny app that allows users to
interactively explore the relationship between **Fire Weather Index
(FWI)** and **burned area** across months.

## 🌐 Pkgdown Documentation Site

You can view the full documentation website here:  
👉
**<https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-quanyu-qian/>**

## 🧠 Background

This package builds upon earlier ETC5523 assignments where ERA5 and
MODIS data were used to study bushfire conditions. For this assignment,
a simplified and synthetic dataset `se_fire_monthly` (12 observations)
was created to demonstrate the link between FWI and burned area. The
dataset was generated using the R script `data-raw/make_data.R`,
ensuring reproducibility.

📘 **View full documentation site here:**  
<https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-quanyu-qian/>

## 🧩 Installation

This is a demonstration package created for ETC5523 Assignment 4.

You can build and load it in **RStudio** using:

``` r
# Load the package in development mode
devtools::load_all()

# Launch the interactive Bushfire Explorer app
run_app()
```

Once loaded, you can explore the relationship between **fire weather
index (FWI)** and **burned area** interactively through the Bushfire
Explorer Shiny app.

## 🚀 Package Features

This package contains the following components:

| Component | Description |
|----|----|
| **`se_fire_monthly`** | A small tidy dataset (12 rows) containing FWI, burned area, and month. |
| **`run_app()`** | A Shiny app that visualises the relationship between FWI and log(burned area) with filters for month and minimum FWI. |
| **Vignette** | Describes how the dataset was processed and how the Shiny app is designed. |
| **`inst/app/www/style.css`** | Provides custom CSS styling for the Shiny interface. |

## 📜 License

This package is released under the **MIT License**.  
The license details are provided in the LICENSE file included in this
package.
