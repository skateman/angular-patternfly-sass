#!/bin/sh

if [ $# != 3 ]; then
  echo "$0: <remote source> <remote destination> <release tag>" 1>&2
  exit 1
fi

git fetch --no-tags $1
git checkout `git ls-remote --tags $1 | grep refs/tags/$3 | cut -f1`
git checkout -b convert-$3

sed -i -e 's/"name": "angular-patternfly"/"name": "angular-patternfly-sass"/' `ls -1 bower.json package.json`
sed -i -e 's/\[ "angular", "patternfly"\]/[ "angular", "patternfly", "sass", "patternfly-sass"]/' bower.json
sed -i -e 's/patternfly\/angular-patternfly/patternfly\/angular-patternfly-sass/g' `ls -1 bower.json package.json`
sed -i -e 's/"patternfly":/"patternfly-sass":/' bower.json
sed -i -e 's/\(description": .*\)",/\1 (patternfly-sass compatible)",/' `ls -1 bower.json package.json`

git commit -am "Converted $3"
git push $2 convert-$3
git tag $3
git push $2 $3
git checkout master
git branch -D convert-$3
git push $2 :convert-$3
