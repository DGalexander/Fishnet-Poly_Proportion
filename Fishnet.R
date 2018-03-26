#### Create a Fishnet, Intersect with resulting proportion ####

## Wd
setwd("~/Fishnet")

## Load the Packages
library(raster)
library(proj4)
library(GISTools)

## Setup Boundary and Fishnet ##

# Set layer CRS
bng <- '+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs'

# Load a .shp file
pdnp <- shapefile("PDNP.shp")

# Change to British National Grid
pdnp <- spTransform(pdnp, bng)

# Create a bounding box
bb <- bbox(pdnp)

# Set the dimensions
grd <- GridTopology(cellcentre.offset = c(bb[1,1], bb[2,1]), cellsize = c(10000,10000), cells.dim = c(5,7))  

# Create the grid layer
grd.layer <- SpatialPolygonsDataFrame(as.SpatialPolygons.GridTopology(grd), data = data.frame(c(1:35)), match.ID = FALSE)
names(grd.layer) <- "ID"

# Lets take a look at the grid
plot(grd.layer, lty = 2)

# Add some labels
Lat <- as.vector(coordinates(grd.layer)[,2])
Lon <- as.vector(coordinates(grd.layer)[,1])
Names <- as.character(data.frame(grd.layer)[,1])
pl <- pointLabel(Lon, Lat, Names, offset = 0, cex = .7)

# Overlay the Polygon
plot(pdnp, add = T)
