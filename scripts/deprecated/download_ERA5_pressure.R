# library(httr)
# library(curlR)

d_url = getProcessInfo()
urls = d_url %$% paste0(url, "\n\tout=", file)
writeLines(urls, "I:/data/EAR5/urls.txt")

{
    # 50, 30, 20
    varnames <- c(
        # 'temperature',
                  # 'v_component_of_wind',
                  'u_component_of_wind',
                  'divergence', 'vorticity'
                  # 'geopotential',
                  # 'relative_humidity',
                  # 'specific_humidity'
                  )
    lst_years <- list(1979:1989, 1990:1999, 2000:2009, 2010:2019, 2020)
    for (varname in varnames) {
        for (years in lst_years) {
            request_ERA5(varname, years, transfer = FALSE)
        }
    }
}
# setwd("N:/DATA/EAR5/")
# files_tmp <- d_url$url %>% basename() %>% paste0("N:/DATA/EAR5/",.)
# file.rename(files_tmp, d_url$file)
