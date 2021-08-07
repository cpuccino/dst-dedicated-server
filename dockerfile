FROM debian:latest

LABEL \
    author="cpuccino" \
    email="thegreatcappuccino@gmail.com" \
    description="Don't Starve Together Dedicated Server" \
    source="https://github.com/cpuccino/dst-dedicated-server" \
    resources="https://steamcommunity.com/id/ToNiO44/myworkshopfiles/?section=guides&appid=322330"

# Don't Starve Together Dedicated Server App ID https://steamdb.info/app/343050/
ARG APP_ID
ENV APP_ID=${STEAM_APP_ID:-"343050"}

ARG ADMIN_NAME
ENV ADMIN_NAME=${ADMIN_NAME:-"admin_dst"}

ARG SERVER_DIR
ENV SERVER_DIR=${SERVER_DIR:-"server_dst"}

RUN useradd -ms /bin/bash/ ${ADMIN_NAME}
WORKDIR /home/${ADMIN_NAME}
USER ${ADMIN_NAME}

RUN ./scripts/requirements.sh

# Create directories for the base game, mods, save data and logs

RUN ./scripts/steam.sh

# Add volumes for base game, mods, save data and logs