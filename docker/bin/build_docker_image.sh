#!/usr/bin/env bash
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)" ; export PATH="$SCRIPTDIR:$PATH"

_usage () {
    cat <<EOUSAGE
Usage: $0 NAME

NAME must match a file in 'dockerfiles/<name>/Dockerfile'.
EOUSAGE
    exit 1
}

[ $# -gt 0 ] || _usage

img="$1"; shift 1

# Override these with environment variables
DOCKER_BUILD_OPTS="${DOCKER_BUILD_OPTS:-}"
DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME:-$img}"
DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:-latest}"

declare -a docker_args=()
if [ -n "${DOCKER_BUILD_TARGET:-}" ] ; then
    docker_args+=("--target" "${DOCKER_BUILD_TARGET}")
fi

# Note that below, we pass the full path to both the dockerfiles and
# the context directory. So this script can theoretically be run from
# any other directory, as long as you call it with its full path,
# and the files you want to use are relative to this script's location.

# shellcheck disable=SC2086
docker build \
    ${DOCKER_BUILD_OPTS} \
    "${docker_args[@]}" \
    -t "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" \
    -f "$SCRIPTDIR/../dockerfiles/$img/Dockerfile" \
    --build-arg "DEBUG=${DEBUG:-0}" \
    "$SCRIPTDIR/.."

