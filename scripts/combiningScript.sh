#!/bin/bash

# This script quickly juxtaposes two images using imagemagick
# Output is made out of 4 files, combining JPG and TIF output with vertical and horizontal juxtapositions.

if [ -z $1 ] || [ -z $2 ]
then
  echo "Usage: combiningScript.sh [FILES]"
  echo "Please provide at least two file names"
  exit 1
fi
convert $* +append out_horizontal.jpg
convert $* +append out_horizontal.tif
convert $* +append out_horizontal.pdf
convert $* -append out_vertical.jpg
convert $* -append out_vertical.tif
convert $* -append out_vertical.pdf
