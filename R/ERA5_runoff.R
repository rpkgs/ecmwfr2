request_ERA5_others <- function(years,
                                transfer = TRUE, outdir = ".", user = NULL,
                                ds = "reanalysis-era5-pressure-levels-monthly-means") {
    varname <- "runoff"
    if (is.null(user)) user <- getUserInfo()$user

    # months <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
    # levs <- c(1000, 925, 850, 700, 600, 500, 400, 300, 250, 200, 150, 100, 70, 10) %>% as.numeric()
    # if (ds == "reanalysis-era5-land-monthly-means") levs = NULL
    year_begin <- min(years)
    year_end <- max(years)
    years %<>% as.character()
    outfile <- glue::glue("ERA5_{varname}_({year_begin}-{year_end}).grib")
    
    request <- list(
        # "dataset_short_name" = "cems-glofas-historical",
        # "system_version"     = "version_3_1",
        # "hydrological_model" = "lisflood",
        'system_version'     = 'version_2_1',
        'hydrological_model' = 'htessel_lisflood',
        
        "product_type"       = "consolidated",
        "variable"           = "river_discharge_in_the_last_24_hours",
        "hyear"              = years,
        "hmonth"             = c("april", "august", "december", "february", "january", "july", "june", "march", "may", "november", "october", "september"),
        "hday"   = sprintf("%02d", 1:31),
        "format" = "grib", # netcdf
        "target" = outfile
    ) %>% rm_empty()
    ecmwfr::wf_request(
        user = user, # user ID (for authentification)
        request = request, # the request
        transfer = transfer, # download the file
        path = outdir
    )
}
