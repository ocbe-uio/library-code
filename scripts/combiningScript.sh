#!/bin/bash

# This script quickly juxtaposes two images using imagemagick
# Output is made out of 4 files, combining JPG and TIF output with vertical and horizontal juxtapositions.

convert $* +append out_horizontal.jpg
convert $* +append out_horizontal.tif
convert $* -append out_vertical.jpg
convert $* -append out_vertical.tif
