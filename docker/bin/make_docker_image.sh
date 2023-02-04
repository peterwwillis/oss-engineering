#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

_usage () {
    cat <<EOUSAGE
Usage: $0 NAME

NAME must match a file in 'dockerfiles/<name>.Dockerfile'.
EOUSAGE
    exit 1
}

[ $# -gt 0 ] || _usage

img="$1"; shift 1

# Override these with environment variables
DOCKER_BUILD_OPTS="${DOCKER_BUILD_OPTS:-}"
DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME:-$img}"
DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:-latest}"

# shellcheck disable=SC2086
docker build \
    ${DOCKER_BUILD_OPTS} \
    -t "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" \
    -f "dockerfiles/$img.Dockerfile" \
    --build-arg "DEBUG=$DEBUG" \
    .
