#' c_request
#' 
#' @param ... other parameters to [ecmwfr::wf_request()]
#' 
#' @import ecmwfr
#' @export
c_request <- function(param, dsname = "reanalysis-era5-single-levels",
                      outfile = NULL, 
                      transfer = FALSE, 
                      user = NULL, 
                      ...) {
  param$year %<>% as.character()
  param$dataset_short_name <- dsname
  
  if (is.null(user)) user <- getUserInfo()$user
  
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
