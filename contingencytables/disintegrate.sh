#! /bin/bash
# This is an unclever play on words with the filename "integrate.sh". This script undoes closes the work done for a function.

feature_branch=$(git branch --show-current)

# Commiting changes
echo -e "\n\e[0;34m# Pending changes\e[0m\n"
git status
echo -e "\n\e[0;34m# Some rethorical questions\e[0m\n"
echo -en "\nWere the new functions added to chapters.R?"
read rethorical_question
echo -en "Were unit tests written?"
read rethorical_question
echo -en "Has the package passed devtools::test()?"
read rethorical_question
echo -en "Proceed with commits [Y/n]?"
read proceed_yn
if [ $proceed_yn = 'n' ]
then
	echo "Exiting"
	exit 0
fi

echo -e "\n\e[0;34m# Commiting changes\e[0m\n"
git add R/$feature_branch.R
git commit -m "Reformatted function"
git add R/chapters.R
git commit -m "Added function to chapter list"
git add tests/testthat/*
git commit -m "Added unit tests"
git add man/$feature_branch.Rd
git commit -m "Updated docs"

echo -e "\n\e[0;34m# Branch switching\e[0m\n"
echo "On branch $feature_branch. Switching to develop"
git checkout develop

echo -e "\n\e[0;34m# Merging $feature_branch into develop\e[0m\n"
echo -en "Enter chapter number: "
read chap_num
git merge $feature_branch -m "Merged $feature_branch with develop (#$chap_num)"
git branch --delete $feature_branch

echo -e "\n\e[0;34m# Updated git log\e[0m\n"
git log --graph --pretty=format:'%C(yellow)%d%Creset %s %Cgreen(%cr)' -n 10
echo -en "\nPush to remote and edit github issue [y/N]? "
read push_yn
if [ "$push_yn" = 'y' ]
then
	git push
fi
