FROM debian:latest

LABEL \
    author="cpuccino" \
    email="thegreatcappuccino@gmail.com" \
    description="Don't Starve Together Dedicated Server" \
    source="https://github.com/cpuccino/dst-dedicated-server" \
    resources="https://steamcommunity.com/id/ToNiO44/myworkshopfiles/?section=guides&appid=322330"

# Don't Starve Together Dedicated Server App ID https://steamdb.info/app/343050/
ARG STEAM_APP_ID="343050"

# Create a user that manages the server

# Install the required packages

# Create directories for the base game, mods, and save data

# Install the base game via steamcmd

# Add volumes for base game, mods and save data