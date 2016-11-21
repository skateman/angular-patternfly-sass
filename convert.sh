#!/bin/sh

if [ $# != 3 ]; then
  echo "$0: <remote source> <remote destination> <release tag>" 1>&2
  exit 1
fi

git fetch --no-tags $1
git checkout `git ls-remote --tags $1 | grep refs/tags/$3 | cut -f1`
git checkout -b convert-$3

sed -i -e 's/"name": "angular-patternfly"/"name": "angular-patternfly-sass"/' bower.json package.json
sed -i -e 's/\[\s*"angular",\s*"patternfly"\s*\]/["angular", "patternfly", "sass", "patternfly-sass"]/' bower.json package.json
sed -i -e 's/patternfly\/angular-patternfly/patternfly\/angular-patternfly-sass/g' bower.json package.json
sed -i -e 's/"patternfly":/"patternfly-sass":/' bower.json package.json
sed -i -e 's/\(description": .*\)",/\1 (patternfly-sass compatible)",/' bower.json package.json

git commit -am "Converted $3"

# push & publish
git push $2 convert-$3
git tag $3
git push $2 $3
npm publish

# cleanup
git checkout master
git branch -D convert-$3
git push $2 :convert-$3
