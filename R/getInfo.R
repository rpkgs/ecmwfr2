#' get user info from keyring
#'
#' @import keyring
#' @export
getUserInfo <- function(service = "ecmwfr_cds") {
    keys <- key_list() %>% .[.$service == service, ]
    user <- keys$username
    key <- key_get(service = service, username = user)
    list(key = key, user = user)
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
    # browser()
    df <- lapply(data, function(x) {
        url <- x$status$data[[1]]$location
        file <- x$request$specific$target
        state <- x$status$state
        data.frame(file, state, url)
    }) %>% do.call(rbind, .)
    df
}
