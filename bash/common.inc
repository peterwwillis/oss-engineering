#!/usr/bin/env bash
# vim: syntax=bash

_usage () {
    if [ $# -lt 1 ] ; then
        printf "%s\n" "$_usage_txt"
    else
        printf "%s\n" "$*"
    fi
    exit 1
}
_cmd () {
    name="$1"; shift 1
    if [ "$(type -t _cmd_"${name}_${1:-}")" = "function" ] ; then
        cmd="$1"; shift 1 ; _cmd_"${name}_${cmd}" "$@"
        exit $?
    fi
}
_list_script_cmds_from_path () {
    (
        ls "$SCRIPTDIR"/"${SCRIPT}"_* 2>/dev/null
        ls "$SCRIPTDIR"/../*/bin/"${SCRIPT}"_* 2>/dev/null
        printf "%s\n" "$PATH" \
            | sed -E 's/:/\n/g' \
            | xargs -n1 ls 2>/dev/null \
            | grep -E "/${SCRIPT}_[^/]+$"
    ) \
        | sed -E "s/^.*\/${SCRIPT}_(.*)$/\t\1/; s/_/ /g" \
        | sort -u
}
_main () {
    [ $# -gt 0 ] || _usage
    cmd="$1"; shift 1
    # Try to run an internal function first
    if [ "$(type -t "_cmd_$cmd")" = "function" ] ; then
        "_cmd_$cmd" "$@"
    # Otherwise run any matching script in the PATH. This way someone can
    # overload the existing set of scripts with their own scripts
    elif command -v "${SCRIPT}_$cmd" >/dev/null ; then
        "${SCRIPT}_$cmd" "$@"
    # Otherwise look relative to this script's directory for a matching
    # command script
    elif [ -x "$SCRIPTDIR/../$cmd/bin/${SCRIPT}_$cmd" ] ; then
        "$SCRIPTDIR/../$cmd/bin/${SCRIPT}_$cmd" "$@"
    else
        _err "Invalid command: '$cmd'"
        _usage
    fi
}
_log () { printf "%s\n" "$*" 1>&2 ; }
_info () { _log "$SCRIPT: INFO: $*" ; }
_err () { _log "$SCRIPT: ERROR: $*" ; }
_errexit () { _err "$*" ; exit 1 ; }

