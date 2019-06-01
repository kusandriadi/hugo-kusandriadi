#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo -e "\033[0;32mBuild Module\033[0m"
hugo -t hugo-theme-minos # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
echo -e "\033[0;32mAdding changes before commit...\033[0m"
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

echo -e "\033[0;32mCommit Changes\033[0m"
git commit -m "$msg"

# Push source and build repos.
echo -e "\033[0;32mPush Changes\033[0m"
git push origin master

echo -e "\033[0;32mFinish!\033[0m"
# Come Back up to the Project Root
cd ..
