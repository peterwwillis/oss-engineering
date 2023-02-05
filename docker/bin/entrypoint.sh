#!/usr/bin/env bash
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

# We have to load this for non-interactive shells or asdf will not be loaded
if [ -r /etc/profile ] ; then
    # shellcheck disable=SC1091
    . /etc/profile
fi
