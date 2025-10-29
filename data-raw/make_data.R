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
