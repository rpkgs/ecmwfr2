#' @import magrittr
#' @export
login <- function() {
  infile = "~/.cdsapirc"
  infile = "C:/Users/kong/.cdsapirc"

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
getProcessInfo <- function() {
  info <- getUserInfo()
  data <- httr::GET(
    "https://cds.climate.copernicus.eu/broker/api/v1/0/requests",
    httr::authenticate(info$user, info$key)
  ) %>% content()
  df <- lapply(data, function(x) {
    url <- x$status$data[[1]]$location
    file <- x$request$specific$target
    state <- x$status$state
    data.frame(file, state, url)
  }) %>% do.call(rbind, .)
  df
}
