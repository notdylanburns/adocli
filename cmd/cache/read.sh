#!/bin/bash

source "$CLI_SH"

import cache
import errors
import utils

export CMD_ARGS_FILE="${CMD_DIR}/${CMD_NAME}.args"
export CMD_CHILD_DIR=
export CMD_SUBCOMMAND_VAR=

help() {
    echo "${CMD_CALLED_AS}: read a value from the cache"
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

    if [[ -z "$cache_key" ]] ; then
        cache_key='.'
    fi

    if [[ -n "$ignore_expiry" ]] ; then
        if ! get_exit_code "read_cache_force '${cache_key}'" ; then 
            perror "$CMD_CALLED_AS" $_CODE
            exit $?
        fi
    else
        if ! get_exit_code "read_cache '${cache_key}'" ; then
            perror "$CMD_CALLED_AS" $_CODE
            exit $?
        fi
    fi

    echo
}

parse_args $@
args_valid="$?"

main
