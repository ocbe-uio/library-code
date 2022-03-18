#!/bin/bash
# This script searches for a Markdown image argument and replaces it with
# an HTML version of it that allows resizing.

# Running the script without arguments shows a help text
if [ -f $1 ]
then
	echo "Usage: resizeMarkdownImage.sh [FILE] [IMAGE]"
else
	# Storing variables and executing replacement
	FILE=$1
	IMAGE=$2
	IMAGEMD="!\[\]($IMAGE)"
	sed -i "s+$IMAGEMD+<img src="$IMAGE" style="zoom:50%">+" "$FILE"
fi
