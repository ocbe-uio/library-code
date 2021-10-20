#!/bin/bash
# This is a script to streamline R packge building and checking

# Old implementation
# echo -e "Listing package files\n"
# ls cellmigRation_*
# read -p "Enter file name to check: " FILENAME
# R CMD check --as-cran $FILENAME

while getopts 'c' opt
do
	case $opt in
		c) CHECK_OPTS="--as-cran" ;;
	esac
done

echo "R CMD check $CHECK_OPTS $1"

