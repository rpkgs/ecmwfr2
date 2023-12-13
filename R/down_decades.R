#' @export
get_years <- function(decade = 2020) {
  # if (decade == 1950) {
  #   1959
  if (decade == 2020) {
    2020:2022
  } else {
    seq(decade, decade + 9)
  }
}


#' @export
down_var <- function(
    var, param, dsname,
    decades = seq(1950, 2020, 10),
    yearly = FALSE,
    prefix = "ERA5_", ...) {
  param$variable <- var
  # decades <- seq(decade_begin, decade_end, 10)

  if (!yearly) {
    for (decade in decades) {
      years <- get_years(decade)
      param$year <- years

      param$target <- sprintf("%s%s_%d-%d.nc", prefix, var, min(years), max(years))
      print(param$target)
      # print(param)
      c_request(param, dsname, ...)
    }
  }
}

#' @export
down_vars <- function(vars, param, dsname, ...) {
  lapply(vars, function(var) down_var(var, param, dsname, ...))
}
