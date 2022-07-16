library(terra)
library(raster)

r = rast("H:/global_WB/basemap/ERA5/yearly/ERA5_yearly_mean_evaporation_rate_(1979-2020).nc")
r_bad = rast("H:/global_WB/basemap/ERA5/yearly/ERA5_yearly_evaporation_(1979-2020).nc")

r
write_fig({
    plot(r[[1]] * 86400 * -365)
}, "ERA5_ET_rate.pdf")

write_fig({
    # plot(r[[1]] * 86400 * -365)
    plot(r_bad[[1]] * -1000)
}, "ERA5_ET.pdf")

# r_ratio = (r[[1]] * 86400 * -365) / (r_bad[[1]]*1000)
# plot(r_ratio)
# values(r_ratio) %>% summary()
