# library(httr)
# library(curlR)
library(ecmwfr)
# wf_set_key(user = "kongdd@mail2.sysu.edu.cn",
#            key = "f436eb66ece8fb12140f1b22a0c14c06",
#            service = "webapi")
wf_set_key(user = "12106",
           key = "faa165eb-2d80-4843-9c80-2d5e90adf977",
           service = "cds")

d_url = getProcessInfo()
urls = d_url %$% paste0(url, "\n\tout=", file)
writeLines(urls, "I:/data/EAR5/urls.txt")

varnames = c(
    'evaporation_from_bare_soil',
    'evaporation_from_open_water_surfaces_excluding_oceans',
    'evaporation_from_the_top_of_canopy',
    'evaporation_from_vegetation_transpiration',
    'potential_evaporation',
    'snow_evaporation',
    'runoff',
    'sub_surface_runoff',
    'surface_runoff',
    'total_evaporation')
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
