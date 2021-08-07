#!/usr/bin/env bash

is_integer() {
    local pattern='^[0-9]+$'
    
    if [[ ! "$1" =~ pattern ]]; then
        echo 'false'
        return
    fi

    echo 'true'
}

is_decimal() {
    local pattern='^[0-9]+(\.[0-9]+)?$'
    
    if [[ ! "$1" =~ pattern ]]; then
        echo 'false'
        return
    fi

    echo 'true'
}

is_bool() {
    if [[ -n "$1" ]] && [[ "$1" != 'true' ]] && [[ "$1" != 'false' ]]; then
        echo 'false'
        return
    fi

    echo 'true'
}

valid_or_exit() {
    if [[ "$1" = 'false' ]]; then
        echo "not valid"
        exit 1
    fi
    
    echo "valid"
}