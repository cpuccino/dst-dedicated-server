#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive

set -x

dpkg --add-architecture i386 && \
    apt update && apt upgrade && \
    apt install --no-install-recommends -y \
    wget lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 && \
    chown -R "$ADMIN_NAME:$ADMIN_NAME" ./ && \
    apt clean && \
    rm -rf /tmp/* /var/tmp/* var/lib/apt/lists/*