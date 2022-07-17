library(ecmwfr)


d_url <- getProcessInfo()
urls <- d_url %$% paste0(url, "\n\tout=", file)
writeLines(urls, "I:/data/EAR5/urls.txt")

{
    # 50, 30, 20
    varnames <- c(
        '2m_temperature',
        "2m_dewpoint_temperature",
        "surface_pressure"
        # 'v_component_of_wind',
        # "u_component_of_wind",
        # "divergence", "vorticity"
        # 'geopotential',
        # 'relative_humidity',
        # 'specific_humidity'
    )
    lst_years <- Ipaper::chunk(1959:2021, 4)
    for (varname in varnames[1:2]) {
        for (years in lst_years) {
            request_hourly(varname, years,
                ds = "reanalysis-era5-single-levels", product_type = "reanalysis",
                transfer = FALSE)
        }
    }
}
