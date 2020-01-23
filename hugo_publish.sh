#!/bin/bash

clear
if [ $# -ne 1 ]; then
    echo "Please specify commit message"
    exit
fi

# Show what we'll do
git status
read -p "Add all and publish as : $1 ?"

# Clean the published dir
if [ -d "bernsteining.github.io/.git" ]; then
	/bin/rm -rf bernsteining.github.io/* # Keeps the .git
else
	git clone git@github.com:bernsteining/bernsteining.github.io.git
	/bin/rm -rf bernsteining.github.io/* # Keeps the .git
fi

# Generate static files
hugo -d bernsteining.github.io/
git add .
git status
read -p "Still sure ?"
git commit -a -m "$1"
git push

# Publish the site
pushd bernsteining.github.io/
git add .
git commit -a -m "$1"
git push
popd
