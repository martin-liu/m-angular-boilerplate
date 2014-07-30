#!/bin/bash
grunt build
( cd dist
  REPO=`echo ${GH_REF##*/} | cut -d'.' -f 1`
  grunt regex-replace:travis --repoName=${REPO}
  git init
  git config user.name "Travis-CI"
  git config user.email "travis@martin-liu.com"
  git add .
  git commit -m "Deployed to Github Pages"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
)
