#!/usr/bin/env bash
#/ Usage: steam.sh [options] [--] [<shell-script>...]
#/
#/     -a, --app-id                steam app id
#/     -d, --dir, --install-dir    steam app install dir
#/
#/ Description: This script downloads steamcmd and updates the specified app

function update_app() {
    if [[ ! -f 'steamcmd.sh' ]]; then
        wget -qO - 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxvf -
    fi

    ./steamcmd.sh \
        +@ShutdownOnFailedCommand 1 \
        +@NoPromptForPassword 1 \
        +login anonymous \
        +force_install_dir "$1" \
        +app_update "$2" validate \
        +quit
}

function run() {
    local app_id
    local install_dir

    while [[ $# -gt 0 ]]; do
        local key=$1

        case "$key" in
            -a|--app-id)
                app_id="$2"
                shift; shift;
            ;;
            -d|--dir|--install-dir)
                install_dir="$2"
                shift; shift;
            *)
            shift
            ;;
        esac
    done

    if [[ -z app_id ]] || [[ -z install_dir ]]; then
        echo 'App id and install directory are required'
        exit 1
    fi

    update_app "$install_dir" "$app_id"
}

run