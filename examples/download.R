library(ecmwfr2)
library(data.table)
library(magrittr)
user <- "12106" # kong
# user <- "209037"

while (1) {
  d_url <- getProcessInfo(user = user)
  d_url %<>% .[file != "ERA5_2m_dewpoint_temperature_2022-2022.nc"]

  # 如果所有文件都下载完了
  write_url(d_url)

  cmd <- "aria2c -c -x 5 -s 5 -j 5 --file-allocation=none -i urls.txt -d Z:/ERA5/ERA5_hourly"
  shell(cmd, wait = TRUE)

  # 所有都处理完了
  if (all(d_url[, state == "completed"])) {
    break()
  }
}
