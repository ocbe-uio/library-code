#! /bin/bash
# This script automates the preparation of a script file for integrating the package.

# Validation

if [ -z $1 ]
then
	echo 'Error: you must provide a file path. Maybe you mean to run disintegrate.sh?'
	exit 0
fi

# ======================================================== #
# Moving file to package                                   #
# ======================================================== #

echo -e "\n\e[0;34m# Moving file from aux/ to R/\e[0m"
path_filename=$1
mv -v $path_filename R/

filename_ext=$(echo $path_filename | cut -d '/' -f 3)
filename=$(echo $filename_ext | cut -d '.' -f 1)

# ======================================================== #
# Changing branch + initial commit                         #
# ======================================================== #

echo -e "\n\e[0;34m# Creating $filename branch\e[0m"
git branch $filename

git checkout $filename

echo -e "\n\e[0;34m# Committing original script\e[0m"
git add -A
git commit -m "Added original script"

# ======================================================== #
# Final conveniences                                       #
# ======================================================== #

echo $filename | xclip -selection clipboard
echo $filename
echo -e "\n\e[0;32m Function name copied to clipboard. Opening file in editor...\e[0m"
xdg-open R/$filename_ext

echo -en "Reformat script (take the chance to do a quick tidy-up of the file if you wish) [y/N]? "
read reformat_yn
if [ "$reformat_yn" = 'y' ]
then
	echo -e "\n\e[0;34m# Reformatting\e[0m\nIf this goes wrong, you can reformat the file manually with:"
	echo "reformat.sh R/$filename_ext"
	reformat.sh R/$filename_ext
else
	echo -e "\nWhenever you are ready, run the following to reformat the function:"
	echo "reformat.sh R/$filename_ext"
fi
