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
getUserInfo <- function(service = "ecmwfr_cds", user = NULL) {
  info <- key_list() |> data.table()

  d <- info[info$service == service, ]
  if (!is.null(user)) d = d[username == user, ]

  user <- d$username[1]
  key <- key_get(service = service, username = user)
  list(user = user, key = key)
}

#' get processing information from cds copernicus
#'
#' @import httr
#' @export
getProcessInfo <- function(user = NULL, outfile = "urls.txt", overwrite = TRUE) {
  info <- getUserInfo(user = user)
  data <- httr::GET(
    "https://cds.climate.copernicus.eu/broker/api/v1/0/requests",
    httr::authenticate(info$user, info$key)
  ) %>% content()
  
  d_url <- lapply(data, function(x) {
    url <- x$status$data[[1]]$location
    param = x$request$specific
    file <- param$target
    # print2(param)
    if (is.null(file)) {
      years = param$year %>% unlist() %>% as.numeric()
      var = param$variable %>% unlist() %>% paste(collapse = ",") 
      
      if (is_empty(years)) {
        file <- ""
      } else {
        file = sprintf("ERA5_%s_%d-%d.nc", var, min(years), max(years))
      }
    }
    if (is.null(url)) url = ""
    state <- x$status$state
    data.table::data.table(file, state, url)
  }) %>% do.call(rbind, .)

  write_url(d_url, outfile, overwrite)
  d_url
}

#' @import data.table
#' @export
#' @rdname getProcessInfo
write_url <- function(d_url, outfile = "urls.txt", overwrite = TRUE) {
  urls <- d_url[file != "" & url != "", ] %$%
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

is_empty <- function(x) {
  is.null(x) || (is.data.frame(x) && nrow(x) == 0) || length(x) == 0
}
