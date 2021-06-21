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

echo 'Moving file from aux/ to R/'
path_filename=$1
mv -v $path_filename R/

filename_ext=$(echo $path_filename | cut -d '/' -f 3)
filename=$(echo $filename_ext | cut -d '.' -f 1)

# ======================================================== #
# Changing branch + initial commit                         #
# ======================================================== #

echo -e "\nCreating $filename branch"
git branch $filename

git checkout $filename

echo -e "\nCommitting original script"
git add -A
git commit -m "Added original script"

# ======================================================== #
# Final conveniences                                       #
# ======================================================== #

echo $filename | xclip -selection clipboard
echo $filename
echo -e "\nFunction name copied to clipboard. Opening file in editor..."
xdg-open R/$filename_ext

echo -en "Reformat script [y/N]? "
read reformat_yn
if [ "$reformat_yn" = 'y' ]
then
	echo -e "\nReformatting. If this goes wrong, you can reformat the file manually with:"
	echo "reformat.sh R/$filename_ext"
	reformat.sh R/$filename_ext
else
	echo "Whenever you are ready, run the following to reformat the function:"
	echo "reformat.sh R/$filename_ext"
fi
