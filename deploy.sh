#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo -e "\033[0;32mRemove public\033[0m"
git rm -rf --cached public
rm -rf public

echo -e "\033[0;32mForce submodule\033[0m"
git submodule add --force -b master git@github.com:kusandriadi/kusandriadi.github.io.git public

echo -e "\033[0;32mBuild Module\033[0m"
hugo -t hugo-theme-minos # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
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

# Come Back up to the Project Root
cd ..
