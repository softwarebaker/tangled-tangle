#!/usr/bin/env sh

# ATTENTION!
#   1) The file 'configure-local.sh' is designed to adapt the script './configure' to the developer's local environment.

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
