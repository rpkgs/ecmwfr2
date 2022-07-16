
# ecmwfr2

<!-- badges: start -->
<!-- badges: end -->

## Goals:

> Submit `ERA5` downloading tasks in batch and download them with modern parallel downloading tool `aria2c`.

解决`cdsapi`的痛点：

- 不能并行提交任务
- 单线程下载速度过慢


## Installation

``` r
remotes::install_github("rpkgs/ecmwfr2")
```

## Usage

### 授权

1. 登陆下面的网址，即可显示api key，形式如下：

    <https://cds.climate.copernicus.eu/api-how-to>

    ```bash
    url: https://cds.climate.copernicus.eu/api/v2
    key: 12106:faa165eb-2d80-4843-9c80-2d5e90adf***
    ```

2. 将api保存至`~/.cdsapirc`

### Examples

- **1. 下载1959-2021 ERA5 hourly地表气象数据**

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

## Known issues

1. keyring 授权不适用于wsl
