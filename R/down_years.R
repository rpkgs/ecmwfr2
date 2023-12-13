down_yearly <- function(
    var, param, dsname,
    years = 1961:2022,
    prefix = "ERA5_", ...) {
  
  param$variable <- var
  # decades <- seq(decade_begin, decade_end, 10)
  for (year in years) {
    # years <- get_years(decade)
    param$year <- year

    param$target <- sprintf("%s%s_%d.nc", prefix, var, year)
    print(param$target)
    # print(param)
    c_request(param, dsname, ...)
  }
}

down_yearly_vars <- function(
    vars, param, dsname,
    years = 1961:2022,
    prefix = "ERA5_", ...) {
  for (var in vars) {
    down_yearly(var, param, dsname, years, prefix, ...)
  }
}
