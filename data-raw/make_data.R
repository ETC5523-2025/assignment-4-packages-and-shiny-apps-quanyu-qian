#' Simulated dataset for the Bushfire Explorer app
#'
#' This script generates a synthetic dataset (se_fire_monthly) that mimics
#' the relationship between Fire Weather Index (FWI) and burned area.
#' The data are simulated for demonstration purposes, not from real records.
#'
#' The resulting dataset is saved into the package for use in the Shiny app.
#'
#' Steps:
#' 1. Generate random FWI values (10–59 range).
#' 2. Compute burned_area using an exponential function with random noise.
#' 3. Assign random month labels.
#'
#' The dataset is used in the Shiny app to demonstrate interactive filtering.
# Demo dataset that mimics the relationship between Fire Weather Index (FWI) and burned area
set.seed(123)

# Generate denser FWI values (100 observations)
FWI <- runif(100, 10, 59)

# Burned area (in hectares): exponential growth pattern + random noise
burned_area <- exp(0.07 * FWI + rnorm(100, 0, 0.7)) * 30

# Random months (for grouping in the Shiny app)
month <- sample(month.abb, 100, replace = TRUE)

# Build dataset
se_fire_monthly <- data.frame(
  month = month,
  FWI = FWI,
  burned_area = round(burned_area)
)

# Save dataset to the 'data/' folder for package access
usethis::use_data(se_fire_monthly, overwrite = TRUE)
