#!/bin/bash

# Create new github repo from the command line.
# Gather constant vars

# usage=> ./create.sh "name" "account" "token"

GITHUBUSER=$2
TOKEN=$3
NAME=$1
DESC="Blog of ${1}"


curl -s -u "${GITHUBUSER}:${TOKEN}" https://api.github.com/user/repos -d "{\"name\": \"${NAME}\", \"description\": \"${DESC}\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false, \"has_pages\": true}"

# echo "done"
