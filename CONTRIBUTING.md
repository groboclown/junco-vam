# Contributing to the Project

So you want to help see this project grow and evolve.  You're welcome to join!  You just need to abide by a few rules and processes.


## Building and Testing

Those contributing changes to the source code must ensure the changes compile, pass all existing tests, and do not drop the code coverage percentage.


## GitFlow

This project uses a form of GitFlow such that:

* `main` branch reflects the set of changes preparing to go out into the next release.
* `release` branch reflects the most recently released version of the software.
* PRs in progress merge into the `main` branch, or, in the case of teams working on a single feature, share a branch in the form "(type).(title)" - where type represents the issue type (feature, bug, doc, test, etc.).


## Contributing Patches

* Contributors must submit their patches under the project's license.
* Contributors with repository write access must collect the changes in a "(type).(title)" style branch name.
* Contributors must submit the change as a PR.

The team that approves the PR change will then *squash merge* the change into the `main` branch.  The squash merge must contain in the description the complete change information, in the `CHANGELOG.md` format.


## Releasing

When the team wants to release a new version, it follows this process.

* Create a `release-(version)` branch off the `main` branch.
  * Bump the `version.txt` number.
  * Update the `CHANGELOG.md` file to include all PR changes merged into the main branch since the last release.
  * Create a PR off the branch to merge into `release`.
* Run various non-automated checks on the release.  *Under development.*
* Merge the PR into the `release` branch.
* Create a GitHub release with the artifacts, and tag the release with the version number.
