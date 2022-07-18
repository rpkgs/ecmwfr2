library(ecmwfr2)
# login()

param <- list(
  product_type = "reanalysis",
  format = "netcdf",
  # format = "grib",
  variable = c("2m_dewpoint_temperature", "2m_temperature", "skin_temperature"),
  time = c("00:00", "06:00", "12:00", "18:00"),
  year = c("2010"),
  month = sprintf("%02d", 1:12),
  day = sprintf("%02d", 1:31)
)

dsname = "reanalysis-era5-single-levels"

vars <- c(
  "2m_temperature",
  "2m_dewpoint_temperature",
  "skin_temperature"
  # "surface_pressure"
  # 'v_component_of_wind',
  # "u_component_of_wind",
  # "divergence", "vorticity"
  # 'geopotential',
  # 'relative_humidity',
  # 'specific_humidity'
)

down_vars(vars, param, dsname)
# down_var(vars[1], param, dsname, decades = 2010)

## 02. download with `aria2c`
d_url <- getProcessInfo()
