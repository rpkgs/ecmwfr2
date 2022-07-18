#' @import magrittr
#' @export
login <- function() {
  # infile = "~/.cdsapirc"
  infile = sprintf("%s/.cdsapirc", Sys.getenv("USERPROFILE"))

  info = read.table(infile)$V2[2] %>% {strsplit(., ":")[[1]]}
  user = info[1]
  key = info[2]
  # webapi
  wf_set_key(user = user, key = key, service = "cds")
}


#' get user info from keyring
#'
#' @import keyring
#' @export
getUserInfo <- function(service = "ecmwfr_cds") {
  info <- key_list()
  user <- info[info$service == service, ]$username
  key <- key_get(service = service, username = user)
  list(user = user, key = key)
}

#' get processing information from cds copernicus
#'
#' @import httr
#' @export
getProcessInfo <- function(outfile = "urls.txt", overwrite = TRUE) {
  info <- getUserInfo()
  data <- httr::GET(
    "https://cds.climate.copernicus.eu/broker/api/v1/0/requests",
    httr::authenticate(info$user, info$key)
  ) %>% content()
  df <- lapply(data, function(x) {
    url <- x$status$data[[1]]$location
    param = x$request$specific
    file <- param$target

    if (is.null(file)) {
      years = param$year %>% unlist() %>% as.numeric()
      var = param$variable %>% unlist() %>% paste(collapse = ",")
      file = sprintf("ERA5_%s_%d-%d.nc", var, min(years), max(years))
    }
    if (is.null(url)) url = ""
    state <- x$status$state
    data.frame(file, state, url)
  }) %>% do.call(rbind, .)

  write_url(df, outfile, overwrite)
  df
}

#' @export 
#' @rdname getProcessInfo
write_url <- function(d_url, outfile = "urls.txt", overwrite = TRUE) {
  urls <- subset(d_url, state == "completed") %$% 
    sprintf("# %s \n%s\n\tout=%s", file, url, file)
  
  if (!file.exists(outfile) || overwrite) {
    if (file.exists(outfile)) file.remove(outfile)
    writeLines(urls, outfile)
  }
  invisible()
}

`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

rm_empty <- function(x) {
  if (is.list(x)) {
    x[!sapply(x, is_empty)]
  } else {
    x[!is.na(x)]
  }
}
