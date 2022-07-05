#!/usr/bin/env sh

# ATTENTION!
#   1) The file 'configure-local.sh' is designed to adapt the script './configure' to the developer's local environment.
#   2) Before using run following command: 'git update-index --skip-worktree configure-local.sh'. 
#      The –skip-worktree option ignores uncommitted changes in a file that is already tracked and git will always use the file content from the staging area. 
#      This is useful when we want to add local changes to a file without pushing them to the upstream.

# How use this file: 
#   1. Set appropriate parameters for './configure' script.
#   2. Just run 'source configure-local.sh'.

autoreconf -fi .

./configure \
    BUILD_VERSION=$(git describe --tags) \
    POSTGRES_SUPERUSER="an.romanov" \
    POSTGRES_AUTH_METHOD="peer" \
    TARGET_ARCH="aarch64-apple-darwin" \
    BUILD_MODE="debug"
