# %%
import cdsapi
import os
c = cdsapi.Client()

params = {
    'system_version': 'version_3_1',
    'hydrological_model': 'lisflood',
    'product_type': 'consolidated',
    'variable': 'river_discharge_in_the_last_24_hours',
    'hyear': '1981',
    'hmonth': [
        'april', 'august', 'december',
        'february', 'january', 'july',
        'june', 'march', 'may',
        'november', 'october', 'september',
    ],
    'hday': [
        '01', '02', '03',
        '04', '05', '06',
        '07', '08', '09',
        '10', '11', '12',
        '13', '14', '15',
        '16', '17', '18',
        '19', '20', '21',
        '22', '23', '24',
        '25', '26', '27',
        '28', '29', '30',
        '31',
    ],
    'format': 'grib',  # grib, netcdf
}

for year in reversed(range(1979, 2021)):
    params['hyear'] = year
    outfile = "/mnt/h/ERA5_runoff/cems-glofas-historical_" + str(year) + '.grib'
    if os.path.isfile(outfile): 
        continue
    print(outfile)
    c.retrieve('cems-glofas-historical', params)  #, outfile
