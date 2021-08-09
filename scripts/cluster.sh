#!/usr/bin/env bash
#/ Usage: cluster.sh cluster/config/path

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

set_cluster_key $1
set_cluster_token $1