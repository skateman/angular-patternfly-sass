# Official SASS port for [angular-patternfly](https://github.com/patternfly/angular-patternfly)

This repository contains a special version of [angular-patternfly](https://github.com/patternfly/angular-patternfly) which is dependent on the [SASS port](https://github.com/patternfly/patternfly-sass) of PatternFly.

* Web site: https://www.patternfly.org
* API Docs: http://angular-patternfly.rhcloud.com/#/api

Because this port differs from the original package in **two lines**, the versions are **stored as git tags only**, i.e. they are not available in branches.

## Conversion
```bash
./convert.sh <remote source> <remote destination> <release tag>
```
This script:
* Downloads the tagged commit from the remote source and creates a new branch
* Replaces the `patternfly` dependency to `patternfly-sass` in `bower.json` and `package.json` and commits it
* Creates the tag and pushes it to the server together with the branch (updating the bower package)
* Publishes the npm package
* The branch is deleted both locally and remotely

## Contributing
We're always interested in contributions from the community.

Please ensure that your PR provides the following:

* Detailed description of the proposed changes
* Rebased onto the latest master commit
