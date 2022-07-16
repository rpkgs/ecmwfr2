# %%
"""
## How to use?

> ERA5数据滞后7天左右，13号，只能下载到6号的数据
> 推荐结合cdo一块使用，cdo用于nc文件的拼接

1. 登陆下面的网址，即可显示api key，形式如下：

    <https://cds.climate.copernicus.eu/api-how-to>

    ```bash
    url: https://cds.climate.copernicus.eu/api/v2
    key: 12106:faa165eb-2d80-4843-9c80-2d5e90adf***
    ```

2. 将api保存至~/.cdsapirc
"""

# %%
import cdsapi
c = cdsapi.Client(wait_until_complete=False)


def make_hours(hour_end=23):
    return ["%02d:00"%(i) for i in range(0, hour_end+1)]

def make_days(day_end=31):
    return ["%02d"%(i) for i in range(0, day_end+1)]

def make_years(decade=2020):
    if decade == 1950:
        years = [1959]
    elif decade == 2020:
        years = [2020, 2021, 2022]
    else:
        years = range(decade, decade+10)
    return years


param = {
        'product_type': 'reanalysis',
        'format': 'netcdf',
        'variable': ['2m_dewpoint_temperature', '2m_temperature', 'skin_temperature'],
        'time': ['00:00', '06:00', '12:00', '18:00',],
        'year': ["2010"],
        'month': ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',],
        'day': make_days(),
    }
print(param)

# decades
# %%
def down_var(var):
    param["variable"] = var

    decades = range(1950, 2022, 10)
    for decade in decades:
        years = make_years(decade)
        year_begin = min(years)
        year_end = max(years)
        outfile = "ERA5_%s_%d-%d.nc" % (var, year_begin, year_end)
        print(outfile)

        years_str = ["%04d"%(i) for i in years]
        param["year"] = years_str
        # print(years_str)
        c.retrieve('reanalysis-era5-single-levels', param) # outfile

def down_vars(vars):
    for var in vars:
        down_var(var)

variables = ['2m_dewpoint_temperature', '2m_temperature', 'skin_temperature']
down_vars(variables)
