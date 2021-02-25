# Description

Compares source contents of a package with git tag in repo, difference is printed.

Files are created at /tmp: package is extracted there and also git repository is cloned there.
These files can be examined manually later after running as well, in the git repository it is even possible to execute git operations.
Because files are created at /tmp, they could be lost on restart, but this also means they don't use up increasingly more disk space.

# Usage

./release-diff-checker.sh PACKAGE GIT_REPO TAG

PACKAGE can be a local compressed package file or a remote URL to one
GIT_REPO can be a local git repository or a URL to one
TAG is the git tag or branch to check the package against

# Example usage
./release-diff-checker.sh path/to/nifi-minifi-cpp-0.9.0-source.tar.gz https://github.com/apache/nifi-minifi-cpp minifi-cpp-0.9.0-RC2

# How it works

Operations can take a few seconds, depending on internet speed if download is required.
Stages are printed during running.
Differences are printed while ignoring .git and .gitignore.

# Example output
Extracting package "/home/adam/work/tmp/release_2021_feb/nifi-minifi-cpp-0.9.0-source.tar.gz" to "/tmp/release_package/"\
Cloning "/home/adam/work/minifi-cpp/" to "/tmp/release_git_repo"\
diff:\
Only in /tmp/release_package/nifi-minifi-cpp-0.9.0-source/libminifi/src/agent: agent_version.cpp
