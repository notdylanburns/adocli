#!/bin/bash

source "$CLI_SH"

import cache

export CMD_ARGS_FILE="${CMD_DIR}/${CMD_NAME}.args"
export CMD_CHILD_DIR=
export CMD_SUBCOMMAND_VAR=

help() {
    echo "${CMD_CALLED_AS}: delete entries from the cache"
    echo

    usage
}

main() {
    if [[ -n "$help" ]] ; then
        help
        exit 0
    elif ! (exit $args_valid) ; then
        print_args_errors
        exit 1
    fi

    if [[ -n "$recursive" ]] ; then
        delete_from_cache_recursively "${cache_key}"
        perror "$CMD_CALLED_AS" $?
        exit $?
    else
        delete_from_cache "${cache_key}"
        perror "$CMD_CALLED_AS" $?
        exit $?
    fi
}

parse_args $@
args_valid="$?"

main
