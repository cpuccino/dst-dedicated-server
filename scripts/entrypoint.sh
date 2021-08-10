#!/usr/bin/env bash

# TODO: Define env cluster name, shard name, persistent storage root, conf dir, and backup log count
# https://support.klei.com/hc/en-us/articles/360029556192-Dedicated-Server-Command-Line-Options-Guide
# Run cluster.sh - to get cluster name

function run() {
    # Check for game updates before start. Klei requires your server to be up to date
    # for it to be visible on the server list.
    ./steam.sh -a $APP_ID -d /$HOME/server

    # TODO: Build mod configurations

    cd /$HOME/server/bin
    ./dontstarve_dedicated_server_nullrenderer \
        -cluster "$CLUSTER_NAME" \
        -shard "$SHARD_NAME" -p \
        -persistent_storage_root "$(dirname "$STORAGE_PATH")"
        -conf_dir "$(basename "$STORAGE_PATH")"
        -backup_log_count "$BACKUP_LOG_COUNT"
}

run