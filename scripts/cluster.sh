#!/usr/bin/env bash
#/ Usage: cluster.sh [options] [--] [<shell-script>...]
#/
#/     -p, --path            cluster path
#/
#/ Description: Updates the cluster key and cluster token in the directory

function set_cluster_key() {
    local cluster_config_path="$1/cluster.ini"

    if [[ ! -f cluster_config_path ]]
        echo "Configuration cluster.ini required"
        exit 1
    fi

    local uuid=$(uuidgen)
    local cluster_key_pattern='cluster_key\s?=\s?.*'
    local cluster_key_value="cluster_key = $uuid"

    echo "Setting cluster key to $uuid"

    sed -i "$cluster_key_pattern/$cluster_key_value"
}

function set_cluster_token() {
    local cluster_token_path="$1/cluster_token.txt"

    echo "Cluster token:"
    read cluster_token

    echo cluster_token > cluster_token_path
}

function run() {
    local path

    while [[ $# -gt 0 ]]; do
        local key=$1

        case "$key" in
            -p|--path)
                path=$2
                shift; shift;
            ;;
            *)
            shift
            ;;
        esac
    done

    if [[ -z path ]]
        echo 'Cluster config path is required'
        exit 1
    fi

    set_cluster_key path
    set_cluster_token path
}

run