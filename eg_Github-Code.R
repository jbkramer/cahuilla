#18-03-01
#JKramer, SDSU Geography

## install packages
library(raster)
library(rgdal)
#library(maptools)(RStoolbox)(tibble)(ggplot2)(sp)(rgeos)(plyr)

##Load stack of MODIS images, annual means 2007-2016 for study area
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Imagery/NDVI/2007-2016/")
all.mod.07.16=raster("ndvi_annual.tif")

##load raster clipped to extent to analyze fringe ag regions

mod.07 = raster("ndvi_annual.tif", band = 1)/10000
mod.08 = raster("ndvi_annual.tif", band = 2)/10000
mod.09 = raster("ndvi_annual.tif", band = 3)/10000
mod.10 = raster("ndvi_annual.tif", band = 4)/10000
mod.11 = raster("ndvi_annual.tif", band = 5)/10000
mod.12 = raster("ndvi_annual.tif", band = 6)/10000
mod.13 = raster("ndvi_annual.tif", band = 7)/10000
mod.14 = raster("ndvi_annual.tif", band = 8)/10000
mod.15 = raster("ndvi_annual.tif", band = 9)/10000
mod.16 = raster("ndvi_annual.tif", band = 10)/10000
plot(mod.09)

stack.mod.07.16 = stack(mod.07,mod.08,mod.09,mod.10,mod.11,mod.12,mod.13,mod.14,mod.15,mod.16)
plot(stack.mod.07.16)
mod.07.16=stack.mod.07.16/10000
plot(mod.07.16)
