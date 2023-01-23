#!/bin/bash

source "$CLI_SH"

import cache
import errors
import utils

export CMD_ARGS_FILE="${CMD_DIR}/${CMD_NAME}.args"
export CMD_CHILD_DIR=
export CMD_SUBCOMMAND_VAR=

help() {
    echo "${CMD_CALLED_AS}: write a value to the cache"
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

    write_cache "$cache_key" "$cache_value"
    perror "$CMD_CALLED_AS" $?
    exit $?
}

parse_args $@
args_valid="$?"

main
