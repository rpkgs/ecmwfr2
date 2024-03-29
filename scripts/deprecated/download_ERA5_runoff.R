# library(httr)
# library(curlR)
library(ecmwfr)
library(glue)

d_url = getProcessInfo()
urls = d_url %$% paste0(url, "\n\tout=", file)
writeLines(urls, "urls.txt")

{
    # 50, 30, 20
    # varnames <- c(
    #     # 'temperature',
    #               # 'v_component_of_wind',
    #               'u_component_of_wind',
    #               'divergence', 'vorticity'
    #               # 'geopotential',
    #               # 'relative_humidity',
    #               # 'specific_humidity'
    #               )
    years = 1997:2020
    # lst_years <- list(1979:1989, 1990:1999, 2000:2009, 2010:2019, 2020)
    # for (varname in varnames) {
    for (year in years) {
        request_ERA5_others(year, transfer = FALSE)
    }
    # }
}

library(latticeMap)
r <- rgdal::readGDAL("H:/ERA5_runoff/cems-glofas-historical_lisflood-v3.1_1993.tif")
write_fig(spplot(r[, 1:2]), "a.pdf", 10, 5)


# setwd("N:/DATA/EAR5/")
# files_tmp <- d_url$url %>% basename() %>% paste0("N:/DATA/EAR5/",.)
# file.rename(files_tmp, d_url$file)
