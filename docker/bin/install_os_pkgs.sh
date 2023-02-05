#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)" ; export PATH="$SCRIPTDIR:$PATH"

### Alpine linux
if command -v apk ; then

    # shellcheck disable=SC2086
    apk add -U --no-cache $ALPINE_PKGS

# Debian / Ubuntu
elif command -v apt-get ; then

    export DEBIAN_FRONTEND="noninteractive"
    # shellcheck disable=SC2086
    apt-get update \
    && apt-get -y install $APT_PKGS \
    && rm -rf /var/lib/apt/lists/*

else
    echo "$0: ERROR: Could not detect package manager"
    exit 1
fi
