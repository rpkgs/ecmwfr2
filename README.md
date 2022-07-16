
# ecmwfr2

<!-- badges: start -->
<!-- badges: end -->

## Goals:

> Submit `ERA5` downloading tasks in batch and download them with modern parallel downloading tool `aria2c`.

解决`cdsapi`的痛点：

- 不能并行提交任务
- 单线程下载速度过慢


## Installation

You can install the released version of ecmwfr2 from [CRAN](https://CRAN.R-project.org) with:

``` r
remotes::install_github("rpkgs/ecmwfr2")
```

## Known issues

1. keyring 授权不适用于wsl

## Example

``` r
library(ecmwfr2)
login()

param <- list(
  product_type = "reanalysis",
  format = "netcdf",
  variable = c("2m_dewpoint_temperature", "2m_temperature", "skin_temperature"),
  time = c("00:00", "06:00", "12:00", "18:00"),
  year = c("2010"),
  month = sprintf("%02d", 1:12),
  day = sprintf("%02d", 1:31)
)

dsname = "reanalysis-era5-single-levels"

vars <- c(
  "2m_temperature",
  "2m_dewpoint_temperature",
  "skin_temperature"
)

# c_request(param, dsname)
down_vars(vars, param, dsname)
```
