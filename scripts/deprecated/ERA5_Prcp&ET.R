# library(httr)
# library(curlR)


d_url = getProcessInfo()
urls = d_url %$% paste0(url, "\n\tout=", file)
writeLines(urls, "I:/urls.txt")

{
    varnames <- c(
        '2m_dewpoint_temperature', '2m_temperature', 
        'evaporation', 'mean_evaporation_rate', 'potential_evaporation', 
        'runoff', 'surface_pressure', 'total_precipitation'
                  # 'relative_humidity',
                  # 'specific_humidity'
                  )
    lst_years <- list(1979:2020) # 1989, 1990:1999, 2000:2009, 2010:
    for (varname in varnames) {
        for (years in lst_years) {
            request_ERA5(varname, years, transfer = FALSE, ds = "reanalysis-era5-single-levels-monthly-means")
        }
    }
}
