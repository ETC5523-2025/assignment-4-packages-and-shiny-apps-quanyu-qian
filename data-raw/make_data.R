
# demo data; replace with ERA5/MODIS later
set.seed(1)
se_fire_monthly <- data.frame(
  month = month.abb,
  FWI = runif(12, 10, 60),
  burned_area = round(runif(12, 1e4, 1e6))
)

usethis::use_data(se_fire_monthly, overwrite = TRUE)
