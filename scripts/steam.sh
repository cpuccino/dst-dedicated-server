#!/usr/bin/env bash

if [[ ! -f 'steamcmd.sh' ]]; then
    wget -qO - "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
fi

./steamcmd.sh \
    +@ShutdownOnFailedCommand 1 \
    +@NoPromptForPassword 1 \
    +login anonymous \
    +force_install_dir "$HOME/$SERVER_DIR" \
    +app_update "$APP_ID" validate \
    +quit