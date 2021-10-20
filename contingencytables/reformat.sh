# !/bin/bash

SCRIPT_PATH=~/UiO/rse-tools/contingencytables

rewrite=TRUE
valid_chapter_number='^[0-9]+$'
ch_num=0
if [ -z $2 ]
then
	if [ $2 = false ] || [ $2 = FALSE ]
	then
		rewrite=FALSE
		if [[ $3 =~ $valid_chapter_number ]]; then
			ch_num=$3
		else
			echo "No chapter number provided. I'll try to estimate it from the code"
		fi
	elif [[ $2 =~ $valid_chapter_number ]]; then
			ch_num=$2
	else
		echo "No chapter number provided. Trying to estimate it from the code"
	fi
fi

if [ $ch_num -eq 0 ]; then
	R -e "source('$SCRIPT_PATH/reformat.R'); reformat('$1', saveOutput=$rewrite)"
else
	R -e "source('$SCRIPT_PATH/reformat.R'); reformat('$1', $ch_num, $rewrite)"
fi

# Post-formatting with styler ------------------------------------------------ #
echo -en "Reformat with Styler (tidy up lines first, including example) [y/N]? "
read reformat_styler
if [ "$reformat_styler" = 'y' ]
then
	R -e "styler::style_file('$1')"
fi
