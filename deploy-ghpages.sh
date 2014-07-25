#!/bin/bash
grunt build
( cd dist
  REPO=`echo ${GH_REF##*/}o | cut -d'.' -f 1`
  sed -i "s#<base href=\"/\">#<base href=\"/${REPO}/\">#g" index.html
  git init
  git config user.name "Travis-CI"
  git config user.email "travis@martin-liu.com"
  git add .
  git commit -m "Deployed to Github Pages"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
)
