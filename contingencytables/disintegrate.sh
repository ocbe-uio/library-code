#! /bin/bash
# This is an unclever play on words with the filename "integrate.sh". This script undoes closes the work done for a function.

feature_branch=$(git branch --show-current)

# Commiting changes
echo -e "# Pending changes"
git status
echo -e "Proceed with commits [Y/n]?"
read proceed_yn
if [ $proceed_yn = 'n' ]
then
	echo "Exiting"
	exit 0
fi

echo -e "# Commiting changes"
git add R/$feature_branch.R
git commit -m "Reformatted function"
git add R/chapters.R
git commit -m "Added function to chapter list"
git add tests/testthat/*
git commit -m "Added unit tests"
git add man/$feature_branch.Rd
git commit -m "Updated docs"

echo -e "# Branch switching\n"
echo "On branch $feature_branch. Switching to develop"
git checkout develop

echo -e "\n# Merging $feature_branch into develop\n"
echo -en "Enter chapter number: "
read chap_num
git merge $feature_branch -m "Merged $feature_branch with develop (#$chap_num)"
git branch --delete $feature_branch

echo -e "\n# Updated git log\n"
git log --graph --pretty=format:'%C(yellow)%d%Creset %s %Cgreen(%cr)' -n 10
echo -en "Push to remote [y/N]? "
read push_yn
if [ "$push_yn" = 'y' ]
then
	git push
fi
