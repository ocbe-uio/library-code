# !/bin/bash

SCRIPT_PATH=~/UiO/rse-tools/contingencytables

rewrite=TRUE
if [ $2 = false ] || [ $2 = FALSE ]
then
	rewrite=FALSE
fi

R -e "source('$SCRIPT_PATH/reformat.R'); reformat('$1', $rewrite)"
