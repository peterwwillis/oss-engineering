#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)" ; export PATH="$SCRIPTDIR:$PATH"

_usage () {
    cat <<EOUSAGE
Usage: $0 [DOCKER_IMAGE_NAME:DOCKER_IMAGE_TAG]

If DOCKER_IMAGE_NAME and DOCKER_IMAGE_TAG are not set as environment variables,
you must pass a command-line argument of the container name and tag.
EOUSAGE
    exit 1
}

# Override these with environment variables
DOCKER_PUSH_OPTS="${DOCKER_PUSH_OPTS:-}"
DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME:-$img}"
DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:-latest}"

if [ -n "${DOCKER_IMAGE_NAME:-}" ] && [ -n "${DOCKER_IMAGE_TAG:-}" ] ; then
    img="${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
else
    [ $# -gt 0 ] || _usage
    img="$1"; shift
fi

# shellcheck disable=SC2086
docker push \
    ${DOCKER_PUSH_OPTS} \
    "$img"
