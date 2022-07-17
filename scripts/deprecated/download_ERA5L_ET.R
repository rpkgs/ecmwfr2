library(latticeMap)
r <- rgdal::readGDAL("H:/ERA5_runoff/cems-glofas-historical_lisflood-v3.1_1993.tif")
g <- r[,,1:2]
df = r@data
# g
library(rcolors)

{
    p <- sp_plot(g)
    write_fig(p, "a.pdf", 10, 5)
}
