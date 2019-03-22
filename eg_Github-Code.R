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

##Load region boundaries
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Region/")
indir.bound = "C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Region/"
boundary.ag = readOGR(paste0(indir.bound,"Boundary_Distrito14-Ag.shp")) #study area including agricultural areas
bound.ag.utm = spTransform(boundary.ag, crs(mod.07.16)) # Change projection to match raster
#boundary.srv = readOGR(paste0(indir.bound,"Survey-Regions.shp"))#regional boundaries

setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Crop/Secretaria_BC/")
indir.owner = "C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Crop/Secretaria_BC/"
colonia.shp = readOGR(paste0(indir.owner,"Colonias.shp")) #privately-owned parcels
ejido.shp = readOGR(paste0(indir.owner,"Ejidos.shp")) #communally-owned parcels
module.shp = readOGR(paste0(indir.owner,"Modulos.shp"))

##Load survey boundaries
indir.survey = "C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Survey/"
parcels.survey = readOGR(paste0(indir.survey,"Parcels-Surveyed.shp"))
parcels.survey$Status
parc.surv.compl = parcels.survey [which (parcels.survey$Status=='Complete'),]
points.ps = readOGR(paste0(indir.survey,"Survey_Loc.shp"))

indir.indiv = "C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Survey/Individual/"
a.1 = readOGR(paste0(indir.indiv,"a_1.shp"))
a.2 = readOGR(paste0(indir.indiv,"a_2.shp"))
b.1 = readOGR(paste0(indir.indiv,"b_1.shp"))
b.2 = readOGR(paste0(indir.indiv,"b_2.shp"))
b.3 = readOGR(paste0(indir.indiv,"b_3.shp"))
b.4 = readOGR(paste0(indir.indiv,"b_4.shp"))
b.5 = readOGR(paste0(indir.indiv,"b_5.shp"))
b.6 = readOGR(paste0(indir.indiv,"b_6.shp"))
q.1 = readOGR(paste0(indir.indiv,"q_1.shp"))
q.2 = readOGR(paste0(indir.indiv,"q_2.shp"))
q.4 = readOGR(paste0(indir.indiv,"q_4.shp"))
q.5 = readOGR(paste0(indir.indiv,"q_5.shp"))
q.6 = readOGR(paste0(indir.indiv,"q_6.shp"))
q.7 = readOGR(paste0(indir.indiv,"q_7.shp"))
q.8 = readOGR(paste0(indir.indiv,"q_8.shp"))
q.9 = readOGR(paste0(indir.indiv,"q_9.shp"))
q.10 = readOGR(paste0(indir.indiv,"q_10.shp"))
q.11 = readOGR(paste0(indir.indiv,"q_11.shp"))
r.1 = readOGR(paste0(indir.indiv,"r_1.shp"))
r.2 = readOGR(paste0(indir.indiv,"r_2.shp"))
r.3 = readOGR(paste0(indir.indiv,"r_3.shp"))
r.4 = readOGR(paste0(indir.indiv,"r_4.shp"))
r.5 = readOGR(paste0(indir.indiv,"r_5.shp"))
r.6 = readOGR(paste0(indir.indiv,"r_6.shp"))
plot(stack.mod.07.16[[1]])
plot(b.4, add=TRUE)

parclist = c("a.1","a.2","b.1","b.2","b.3","b.4","b.5","b.6","q.1","q.2","q.4","q.5","q.6","q.7","q.8","q.9","q.10","q.11","r.1","r.2","r.3","r.4","r.5","r.6")

## Summarize annual statistics #how to conduct on stack?
mean.mod.07=cellStats(mod.07,mean)
mean.mod.08=cellStats(mod.08,mean)
mean.mod.09=cellStats(mod.09,mean)
mean.mod.10=cellStats(mod.10,mean)
mean.mod.11=cellStats(mod.11,mean)
mean.mod.12=cellStats(mod.12,mean)
mean.mod.13=cellStats(mod.13,mean)
mean.mod.14=cellStats(mod.14,mean)
mean.mod.15=cellStats(mod.15,mean)
mean.mod.16=cellStats(mod.16,mean)

##Plot annual valleywide NDVI
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/analysis/")
mean.mod.df=data.frame(mean.mod.07, mean.mod.08, mean.mod.09, mean.mod.10, 
                      mean.mod.11, mean.mod.12, mean.mod.13, mean.mod.14, mean.mod.15, mean.mod.16) #classes.df
colnames(mean.mod.df) = c("2007","2008","2009","2010",
                         "2011","2012","2013","2014","2015","2016")
years = seq(2007,by=1,length=10)
plot(years,mean.mod.df[1,],type="b",xlab="Years",ylab="Mean Valleywide NDVI")

#Create empty dataframe for mean modis ndvi for surveyed parcels
modis.07.16.matrix = matrix(nrow=24,ncol=10)
modis.07.16.df = as.data.frame(modis.07.16.matrix)
row.names(modis.07.16.df) = parclist
colnames(modis.07.16.df) = years
modis.07.16.df #t(modis.07.16.df) = transpose dataframe

##Extract annual NDVI for a parcel
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Survey/Individual/")
a.1 = readOGR(paste0("a_1.shp"))
plot(mod.07.16[[1]])
plot(a.1,add=TRUE)
#crop.r.1 = crop(mod.07.16, extent(r.1), snap="out") # check extent
#plot(crop.r.1[[1]]) # subset the first layer of the raster brick
#plot(r.1,add=TRUE)
#rast.r.1 = rasterize(r.1, crop.r.1) # turn shapefile into a raster the image
#mask.r.1 = mask(x=crop.r.1, mask=rast.r.1) # crop raster to extent of study area

mod.a.1 = extract(mod.07.16,a.1,fun=mean)
mod.a.1
plot(years,mod.a.1) # plot annual NDVI for a parcel

## Load mean GEE Landsat value for the same parcel, plot it
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/imagery/LANDSAT/Survey/")
gee.q.6=read.table("q_6.csv",sep=",",header=TRUE)
colnames(gee.q.6) = c("DD-MM-YY","NDVI")
plot(gee.q.6, xlab="Date", main="LANDSAT NDVI")

#Create empty dataframe for GEE landsat ndvi for surveyed parcels
landsat.07.16.matrix = matrix(nrow=120,ncol=24)
landsat.07.16.df = as.data.frame(landsat.07.16.matrix)
row.names(landsat.07.16.df) = gee.a.1[,1]
colnames(landsat.07.16.df) = t(parclist)
landsat.07.16.df

## Plot MODIS and LANDSAT value on same graph # How to do with different timescales?
years.1.1=seq(as.Date("2007/1/1"), as.Date("2016/1/1"), by = "year")
colnames(mod.a.1)=as.character(years.1.1)
barplot(mod.a.1, col="blue3",ylim=c(0,max(gee.a.1$NDVI)+0.1)) #expand y axis to include max NDVI values from LANDSAT imagery
points(gee.a.1, pch=3, col="orange")
abline(lsfit(1:10,mod.a.1[1,]),col="yellow2") #Add trendline for annual mean (MODIS)
abline(h=max(gee.a.1$NDVI),col="brown")
legend("topright", c("MODIS","LANDSAT","Trend","Max"),fill=c("blue","orange","yellow2","brown"))

#OR extend mean NDVI to whole year, and plot against

#long.mod.a.1=seq(mod.a.1[,1])
#long.mod.a.1=rbind(long.mod.a.1,mod.a.1[,1])
#plot(long.mod.a.1, type="l", col="blue3")
#points(gee.a.1, pch=3, col="orange")

#Extract mean annual MODIS values for all surveyed parcels
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Survey/Individual/")
#when survey has multiple parcels, calculate mean for all parcels at once - possible in one line/fxn?
mod.a.1 = extract(mod.07.16,a.1,fun=mean) #projection is same but parcels seem offset/stretched horizontally when zoomed
plot(mod.07.16[[1]])
plot(b.4,add=TRUE)
mod.a.2 = extract(mod.07.16,a.2,fun=mean)
mod.b.1 = extract(mod.07.16,b.1,fun=mean) 
mod.b.2 = extract(mod.07.16,b.2,fun=mean) #four layers
mod.b.3 = extract(mod.07.16,b.3,fun=mean) #NA
mod.b.4 = extract(mod.07.16,b.4,fun=mean)
mod.b.5 = extract(mod.07.16,b.5,fun=mean)
mod.b.6 = extract(mod.07.16,b.6,fun=mean)
mod.q.1 = extract(mod.07.16,q.1,fun=mean)
mod.q.2 = extract(mod.07.16,q.2,fun=mean)
mod.q.4 = extract(mod.07.16,q.4,fun=mean)
mod.q.5 = extract(mod.07.16,q.5,fun=mean) #four layers - one for each parcel?
mod.q.6 = extract(mod.07.16,q.6,fun=mean) #two layers
mod.q.7 = extract(mod.07.16,q.7,fun=mean) #three layers
mod.q.8 = extract(mod.07.16,q.8,fun=mean) #three layers
mod.q.9 = extract(mod.07.16,q.9,fun=mean) #four layers
mod.q.10 = extract(mod.07.16,q.10,fun=mean)
mod.q.11 = extract(mod.07.16,q.11,fun=mean) #100 layers
mod.r.1 = extract(mod.07.16,r.1,fun=mean)
mod.r.2 = extract(mod.07.16,r.2,fun=mean)
mod.r.3 = extract(mod.07.16,r.3,fun=mean)
mod.r.4 = extract(mod.07.16,r.4,fun=mean) #three layers
mod.r.5 = extract(mod.07.16,r.5,fun=mean) #six layers
mod.r.6 = extract(mod.07.16,r.6,fun=mean)

#Add values to dataframe

#modis.07.16.df
#rbind or modis.07.16.df[2]=


##Extract Landsat NDVI values for all surveyed parcels
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Survey/Individual/")
#calculate mean for all parcels at once when survey has multiple parcels - possible in one line?
mod.a.1 = extract(mod.07.16,a.1,fun=mean) #projection is same but parcels seem offset/stretched horizontally when zoomed
plot(mod.07.16[[1]])
plot(b.4,add=TRUE)
mod.a.2 = extract(mod.07.16,a.2,fun=mean)
mod.b.1 = extract(mod.07.16,b.1,fun=mean) 
mod.b.2 = extract(mod.07.16,b.2,fun=mean) #four layers
mod.b.3 = extract(mod.07.16,b.3,fun=mean) #NA
mod.b.4 = extract(mod.07.16,b.4,fun=mean)
mod.b.5 = extract(mod.07.16,b.5,fun=mean)
mod.b.6 = extract(mod.07.16,b.6,fun=mean)
mod.q.1 = extract(mod.07.16,q.1,fun=mean)
mod.q.2 = extract(mod.07.16,q.2,fun=mean)
mod.q.4 = extract(mod.07.16,q.4,fun=mean)
mod.q.5 = extract(mod.07.16,q.5,fun=mean) #four layers - one for each parcel?
mod.q.6 = extract(mod.07.16,q.6,fun=mean) #two layers
mod.q.7 = extract(mod.07.16,q.7,fun=mean) #three layers
mod.q.8 = extract(mod.07.16,q.8,fun=mean) #three layers
mod.q.9 = extract(mod.07.16,q.9,fun=mean) #four layers
mod.q.10 = extract(mod.07.16,q.10,fun=mean)
mod.q.11 = extract(mod.07.16,q.11,fun=mean) #100 layers
mod.r.1 = extract(mod.07.16,r.1,fun=mean)
mod.r.2 = extract(mod.07.16,r.2,fun=mean)
mod.r.3 = extract(mod.07.16,r.3,fun=mean)
mod.r.4 = extract(mod.07.16,r.4,fun=mean) #three layers
mod.r.5 = extract(mod.07.16,r.5,fun=mean) #six layers
mod.r.6 = extract(mod.07.16,r.6,fun=mean)

#Fill dataframe with LANDSAT values

#modis.07.16.df
#rbind or modis.07.16.df[2]=

# Plot MODIS labels with LANDSAT labels [Increasing, Decreasing, Constant, Variable]
setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Imagery/NDVI/2007-2016/")
getwd()
indir.unsup=("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/data/Imagery/NDVI/2007-2016/")
list.files(full.names=TRUE)
unsup.class=raster("unsuper.class.tif")
plot(unsup.annual)
plot(unsup.class)
plot(bound.ag.utm, add=TRUE)
#plot(ejido.shp, add=TRUE)
plot(b.pcl, add=TRUE, col="red")
crop.unsup = crop(unsup.annual, extent(bound.ag.utm), snap="out") #minimize extent                  
rast.unsup = rasterize(bound.ag.utm, crop.unsup) #turn shapefile into a raster
mask.unsup = mask(x=crop.unsup, mask=rast.unsup) #clip raster to extent of study area
plot(mask.unsup)

crop.unscla = crop(unsup.class, extent(bound.ag.utm), snap="out") #minimize extent                  
rast.unscla = rasterize(bound.ag.utm, crop.unscla) #turn shapefile into a raster
mask.unscla = mask(x=crop.unscla, mask=rast.unscla) #clip raster to extent of study area
plot(mask.unscla)

ramp.unscla=rep("gray",100)
modis.inc=c(2,5,10,13,14,17,18,20,32,34,39,40,49,56,60,64,72,75,76,77,78,84,93,99)
modis.dec=c(1,7,8,11,12,21,25,26,29,31,45,46,47,48,50,52,63,66,68,70,79,81,83,85,88,94,97,98)
modis.con=c(3,15,22,23,33,38,42,44,54,55,59,67,71,73,89)
modis.var=c(4,6,9,16,19,24,27,28,30,35,36,37,41,43,51,53,57,58,61,62,65,69,74,80,82,86,87,90,91,92,95,96,100)
ramp.unscla[modis.inc]="green"
ramp.unscla[modis.dec]="red3"
ramp.unscla[modis.con]="blue"
ramp.unscla[modis.var]="yellow"
plot(mask.unscla,col=ramp.unsup,border=NA)

modis.reclass = data.frame(from=0:99,to=1:100,becomes=NA)
modis.reclass[modis.inc,"becomes"]=1
modis.reclass[modis.dec,"becomes"]=2
modis.reclass[modis.con,"becomes"]=3
modis.reclass[modis.var,"becomes"]=4

modis.matrix = data.matrix(modis.reclass)

summary(mask.unscla)
rast.4labels = reclassify(mask.unscla,modis.matrix)
summary(rast.4labels)
plot(rast.4labels,col=c("green","red3","blue","yellow"))

h=hist(rast.4labels)
h
s.h = sum(h$counts)
u=hist(mask.unscla)
s.u = sum(u$counts)
s.h-s.u

plot(mask.unscla)
survey = click(b.4classes,n=4,xy=TRUE,type='p')
#str(survey)
#survey.sp = data.frame(survey)

##Extract values for weighted average of RS class per parcel

extract(rast.4labels,parc.surv.compl)
l.parc = extract(rast.4labels,parc.surv.compl,df=TRUE,weights=TRUE)

parc.surv.label = parc.surv.compl$label = c(1:length(parc.surv.compl[,1]))
parc.surv.compl$label = l.parc
head(parc.surv.compl)
plot(parc.surv.compl)

setwd("C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/analysis/Survey/Label/")
getwd()
write.csv(l.parc,file="parc.surv.compl.label.all.csv")
#writeOGR(parc.surv.compl,"C:/Users/Joel/Documents/Czar/MS_GEOG/Research/Cahuilla/analysis/Survey/Label/","parc.surv.compl",driver="ESRI Shapefile")

##Extract values for weighted average of RS class per survey
l.surv = extract(rast.4labels,parc.surv.compl$NOM_AC,df=TRUE,weights=TRUE)

parc.surv.label = parc.surv.compl$label = c(1:length(parc.surv.compl[,1]))
parc.surv.compl$label = l.parc
head(parc.surv.compl)
