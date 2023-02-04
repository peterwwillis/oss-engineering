#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

_usage () {
    cat <<EOUSAGE
Usage: $0 NAME1:TAG1 NAME2:TAG2
EOUSAGE
    exit 1
}

[ $# -eq 2 ] || _usage

pair1="$1" pair2="$2" ; shift 2

# Override these with environment variables
DOCKER_TAG_OPTS="${DOCKER_TAG_OPTS:-}"

# shellcheck disable=SC2086
docker tag \
    ${DOCKER_TAG_OPTS} \
    "$pair1" \
    "$pair2"
