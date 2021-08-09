#!/usr/bin/env bash
#/ Usage: cluster.sh [options] [--] [<shell-script>...]
#/
#/     -p, --path              cluster path
#/     -n, --name              cluster name
#/     -d, --description       cluster description
#/     -p, --password          cluster password
#/
#/ Description: Updates the cluster key and cluster token in the directory

function set_cluster_token() {
    local cluster_token_path="$1/cluster_token.txt"

    echo "Cluster token:"
    read cluster_token

    echo cluster_token > cluster_token_path
}

function set_cluster_field() {
    local cluster_config_path="$1/cluster.ini"
    local cluster_config_key="$2"
    local cluster_config_pattern="$2\s?=\s?.*"
    local cluster_config_value="$3"

    if [[ ! -f cluster_config_path ]]; then
        echo "Configuration cluster.ini required"
        exit 1
    fi

    if [[ -n cluster_config_value ]]; then
        echo "Setting $cluster_config_key to $cluster_config_value"
        sed -i "$cluster_config_pattern/$cluster_config_value"
    fi
}

function run() {
    local path
    local cluster_name
    local cluster_description
    local cluster_password

    while [[ $# -gt 0 ]]; do
        local key=$1

        case "$key" in
            -p|--path)
                path="$2"
                shift; shift;
            ;;
            -n|--name)
                cluster_name="$2"
                shift; shift;
            ;;
            -d|--description)
                cluster_description="$2"
                shift; shift;
            ;;
            -p|--password)
                cluster_password="$2"
                shift; shift;
            ;;
            *)
            shift
            ;;
        esac
    done

    if [[ -z path ]]; then;
        echo 'Cluster config path is required'
        exit 1
    fi

    set_cluster_token path
    set_cluster_field path 'cluster_key' $(uuidgen)
    set_cluster_field path 'cluster_name' cluster_name
    set_cluster_field path 'cluster_description' cluster_description
    set_cluster_field path 'cluster_password' cluster_password
}

run