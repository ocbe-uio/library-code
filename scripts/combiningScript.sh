#!/bin/bash

# This script quickly juxtaposes two images using imagemagick
# Output is made out of 4 files, combining JPG and TIF output with vertical and horizontal juxtapositions.

# Constants
SCRIPTNAME=$(basename $0)

# Functions
function usage {
  cat <<USAGE
  # Usage

    $SCRIPTNAME [OPTIONS] INPUT

  # Options

    -f: Add image settings (see man convert)
    -d: Merge direction (horizontal or vertical; defaults to both)
    -o: Provide custom output variable name
USAGE
  exit 1
}

function merge {
  if [[ $DIRECTION != "vertical" ]]
  then
    setOUTNAME "out_horizontal"
    convert $FLAGS $* +append $OUTNAME.jpg
    convert $FLAGS $* +append $OUTNAME.tif
    convert $FLAGS -density 450 $* +append +repage -quality 100 $OUTNAME.pdf
  fi
  if [[ $DIRECTION != "horizontal" ]]
  then
    setOUTNAME "out_vertical"
    convert $FLAGS $* -append $OUTNAME.jpg
    convert $FLAGS $* -append $OUTNAME.tif
    convert $FLAGS -density 450 $* -append +repage -quality 100 $OUTNAME.pdf
  fi
}

function setOUTNAME {
  if [[ $OUTNAME == "" ]] || [[ $OUTNAME == "out_horizontal" ]]
  then
    OUTNAME=$1
  fi
}

# Parsing arguments
while getopts 'hf:d:o:' OPTION
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
  o)
    OUTNAME=$OPTARG
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
  echo -e "\e[31mError\e[0m: No input files provided. Run $SCRIPTNAME -h for usage"
  exit 1
fi

# Conversion
merge $INPUT
