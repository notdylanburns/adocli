#!/bin/bash

source "$CLI_SH"

export CMD_ARGS_FILE="${CMD_DIR}/${CMD_NAME}.args"
export CMD_CHILD_DIR="${CMD_DIR}/${CMD_NAME}"
export CMD_SUBCOMMAND_VAR='command'

help() {
    echo "${CMD_CALLED_AS}: your description here"
    echo

    usage

    echo
    print_child_commands
}

main() {
    if (exit $args_valid) ; then
        if cmd=$(find_child_command) ; then
            export CMD_CALLED_AS="${CMD_CALLED_AS} ${!CMD_SUBCOMMAND_VAR}"
            export CMD_DIR="${CMD_CHILD_DIR}"
            export CMD_NAME="${!CMD_SUBCOMMAND_VAR}"

            $cmd ${remaining_args[@]}
            
            exit $?
        elif [[ -n "$help" ]] ; then
            help
            exit 0
        fi

        2>&1 echo -e "error: unknown subcommand: ${!CMD_SUBCOMMAND_VAR}\n"
    
        2>&1 usage
        2>&1 echo
        2>&1 print_child_commands

        exit 1
    elif [[ -n "$help" ]] ; then
        help
        exit 0
    fi

    print_args_errors
    exit 1
}

parse_args $@
args_valid="$?"

main
