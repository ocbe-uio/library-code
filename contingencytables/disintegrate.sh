#! /bin/bash
# This is an unclever play on words with the filename "integrate.sh". This script undoes closes the work done for a function.

feature_branch=$(git branch --show-current)

echo "# Branch switching\n"
echo "On branch $feature_branch. Switching to develop"
git checkout develop

echo -e "\n# Merging $feature_branch into develop\n"
echo -en "Enter chapter number: "
read chap_num
git merge $feature_branch -m "Merged $feature_branch with develop (#$chap_num)"
git branch --delete $feature_branch

echo -e "\n# Updated git log\n"
git log --graph --pretty=format:'%C(yellow)%d%Creset %s %Cgreen(%cr)' -n 10
