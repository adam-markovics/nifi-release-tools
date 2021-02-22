#!/usr/bin/env bash

# Compares source contents of a package with git tag in repo, difference is printed
# Files are created at /tmp

# Handle arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 PACKAGE GIT_REPO TAG"
    exit 1
fi

PACKAGE_COPY='/tmp/release.pack'
if [ -f "$1" ]
then
    PACKAGE_COPY="$1"
else
    echo "Downloading package \"$1\" to \"$PACKAGE_COPY\""
    wget "$1" -O "$PACKAGE_COPY" 2>/dev/null
fi
PACKAGE_DIR='/tmp/release_package/'
echo "Extracting package \"$PACKAGE_COPY\" to \"$PACKAGE_DIR\""
rm -rf "$PACKAGE_DIR"
mkdir "$PACKAGE_DIR"
tar -x -f "$PACKAGE_COPY" --directory="$PACKAGE_DIR" 1>/dev/null 2>&1 || unzip "$PACKAGE_COPY" -d "$PACKAGE_DIR" 1>/dev/null 2>&1
SOURCE_DIR=`ls "$PACKAGE_DIR"`
PACKAGE_SOURCE_ABS_PATH="$PACKAGE_DIR""$SOURCE_DIR"

GIT_REPO="$2"
CLONE_DIR='/tmp/release_git_repo'
echo "Cloning \"$GIT_REPO\" to \"$CLONE_DIR\""
rm -rf "$CLONE_DIR"
git clone --branch "$3" "$GIT_REPO" "$CLONE_DIR" 2>/dev/null

echo diff:
diff -r "$PACKAGE_SOURCE_ABS_PATH" "$CLONE_DIR" | grep -Ev 'Only in.*(\.git|\.gitignore)$'
