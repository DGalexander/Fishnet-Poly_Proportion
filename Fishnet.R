#### Create a Fishnet, Intersect with resulting proportion ####

## Wd
setwd("~/Fishnet")

## Load the Packages
library(rgdal)
library(raster)
#library(rgeos)
#library(dismo)
#library(sp)
library(proj4)
library(maptools)
library(GIStools)

## Setup Boundary and Fishnet ##

# Set layer CRS
bng = '+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs'

# Load a .shp file
pdnp <- shapefile("PDNP.shp")

# Change to British National Grid
proj4string(pdnp)<-(bng)

# Take a look
plot(pdnp)

# Create an empty Raster
grid <- raster(extent(pdnp))

# Choose its resolution. 5000 degrees of latitude and longitude.
res(grid) <- 5000

# Make the grid have the same coordinate reference system (CRS) as the shapefile.
proj4string(grid)<-proj4string(pdnp)

# Change to poly
gridpolygon <- rasterToPolygons(grid)

# Overlay the Grid
plot(gridpolygon, add = T)
