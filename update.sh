#!/bin/bash

rm -rf site/
mkdocs build

cp -R site/* .
git add .
git commit -m "$1"
#git push github master:gh-pages
git push github master

