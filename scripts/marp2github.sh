#!/bin/bash
# This script reformats a Markdown file so it's Github-friendly
# TODO: adjust internal cross-reference (Marp uses slide #, GH uses name) 

# ======================================================== #
# Basic elements                                           #
# ======================================================== #

IN_FILE=$1
IN_FILE_NO_EXT=$(echo $IN_FILE | cut -d "." -f 1)
OUT_FILE="$IN_FILE_NO_EXT"_GitHub.md

# ======================================================== #
# Copying original file                                    #
# ======================================================== #

cp $IN_FILE $OUT_FILE

# ======================================================== #
# Adjusting images for GitHub compatibility                #
# ======================================================== #

sed -i -e 's+!\[h:\([[:digit:]]*\)\](\([^[:space:]()]*\))+<img src="\2" height=\1>+g' $OUT_FILE

# ======================================================== #
# Removing YAML header                                     #
# ======================================================== #

sed -i '1,4d' $OUT_FILE

# ======================================================== #
# Final output                                             #
# ======================================================== #

echo -e "Output ready at $OUT_FILE"
