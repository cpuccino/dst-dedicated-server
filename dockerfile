FROM ubuntu:20.04

LABEL \
    author='cpuccino' \
    email='thegreatcappuccino@gmail.com' \
    description='Don\'t Starve Together Dedicated Server' \
    source='https://github.com/cpuccino/dst-dedicated-server' \
    resources='https://steamcommunity.com/id/ToNiO44/myworkshopfiles/?section=guides&appid=322330'

# Master server port
EXPOSE 10998
# Caves server port
EXPOSE 10999
# Master steam server port
EXPOSE 27018
# Caves steam server port
EXPOSE 27019
# Master steam authentication port
EXPOSE 8768
# Caves steam authentication port
EXPOSE 8769

ARG ADMIN_NAME='dontstarvetogether'
# https://steamdb.info/app/343050/
ARG APP_ID
ENV APP_ID=${APP_ID:-'343050'}

# Create admin user directory
RUN useradd -ms /bin/bash/ $ADMIN_NAME

# Set up volumes in user directory
RUN set -x && \
    chown -R $ADMIN_NAME:$ADMIN_NAME

USER $ADMIN_NAME

WORKDIR /home/$ADMIN_NAME
RUN mkdir -p /home/$ADMIN_NAME/server /home/$ADMIN_NAME/scripts

# Update steam
RUN ./scripts/steam.sh -a $APP_ID -d /home/$ADMIN_NAME/server

# Configure volumes
VOLUME ['/home/$ADMIN_NAME/server']

COPY ['./scripts/steam.sh', './scripts/entrypoint.sh', './scripts/cluster.sh' '/home/$ADMIN_NAME/scripts/']

ENTRYPOINT ['home/$ADMIN_NAME/scripts/entrypoint.sh']