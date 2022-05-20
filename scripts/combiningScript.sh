#!/bin/bash

# This script quickly juxtaposes two images using imagemagick
# Output is made out of 4 files, combining JPG and TIF output with vertical and horizontal juxtapositions.

# Constants
SCRIPTNAME=$(basename $0)

# Functions
function usage {
  cat <<USAGE

  # Usage
    $SCRIPTNAME [-f FLAGS] INPUT

  # Options
    -f: Add image settings (see man convert)
    -d: Merge direction (horizontal or vertical; defaults to both)
USAGE
  exit 1
}

# Parsing arguments
while getopts 'hf:d:' OPTION
do
  case $OPTION in
  h)
    usage
    ;;
  f)
    FLAGS=$OPTARG
    ;;
  d)
    DIRECTION=$OPTARG
    ;;
  ?)
    usage
    exit 1
    ;;
  esac
done
shift "$(($OPTIND -1))" # so what remains are just the arguments (not options)

# Validation
INPUT=$*
if [[ $INPUT == "" ]]
then
  echo -e "\e[31mError\e[0m: No input files provided"
  echo "Run $SCRIPTNAME -h for usage"
  exit 1
fi

# Conversion
echo "Merging $*"
if [[ $DIRECTION != "vertical" ]]
then
  convert $FLAGS $* +append out_horizontal.jpg
  convert $FLAGS $* +append out_horizontal.tif
  convert $FLAGS $* +append out_horizontal.pdf
fi
if [[ $DIRECTION != "horizontal" ]]
then
  convert $FLAGS $* -append out_vertical.jpg
  convert $FLAGS $* -append out_vertical.tif
  convert $FLAGS $* -append out_vertical.pdf
fi
