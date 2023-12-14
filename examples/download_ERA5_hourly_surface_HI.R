library(ecmwfr2)

param <- list(
  product_type = "reanalysis",
  format = "netcdf",
  # format = "grib",
  variable = c("2m_dewpoint_temperature", "2m_temperature", "skin_temperature"),
  time = sprintf("%02d:00", 0:23),
  year = c("2010"),
  month = sprintf("%02d", 1:12),
  day = sprintf("%02d", 1:31)
)

dsname <- "reanalysis-era5-single-levels"

vars <- c(
  "2m_temperature"
  # "2m_dewpoint_temperature"
  # "skin_temperature"
  # "surface_pressure"
  # 'v_component_of_wind',
  # "u_component_of_wind",
  # "divergence", "vorticity"
  # 'geopotential',
  # 'relative_humidity',
  # 'specific_humidity'
)

user <- "12106" # kong
# user <- "209037"
down_yearly_vars(vars, param, dsname, years = 1961:2022, user=user)
# down_var(vars[1], param, dsname, decades = 2010)
