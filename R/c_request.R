#' @export
get_years <- function(decade = 2020) {
  if (decade == 1950) {
    1959
  } else if (decade == 2020) {
    2020:2021
  } else {
    seq(decade, decade + 9)
  }
}

#' c_request
#' 
#' @param ... other parameters to [ecmwfr::wf_request()]
#' 
#' @import ecmwfr
#' @export
c_request <- function(param, dsname = "reanalysis-era5-single-levels",
                      outfile = NULL, transfer = FALSE, ...) {
  param$year %<>% as.character()
  param$dataset_short_name <- dsname

  user <- getUserInfo()$user
  if (!is.null(outfile)) param$target <- outfile
  if (is.null(param$target)) {    
    transfer %<>% `%||%`(FALSE)
    path <- "~"
  } else {
    transfer %<>% `%||%`(TRUE)
    path <- dirname(param$target)
  }
  
  param %<>% rm_empty()
  suppressMessages({
    ecmwfr::wf_request(
      user     = user, # user ID (for authentification)
      request  = param, # the request
      transfer = transfer, # download the file
      path     = path, ...
    )
  })
}


#' @export
down_var <- function(var, param, dsname, 
  decades = seq(1950, 2020, 10), prefix = "ERA5_", ...) 
{
  param$variable <- var
  # decades <- seq(decade_begin, decade_end, 10)

  for (decade in decades) {
    years <- get_years(decade)
    param$year <- years

    param$target <- sprintf("%s%s_%d-%d.nc", prefix, var, min(years), max(years))
    print(param$target)
    c_request(param, dsname, ...)
  }
}

#' @export
down_vars <- function(vars, param, dsname, ...) {
  lapply(vars, function(var) down_var(var, param, dsname, ...))
}
