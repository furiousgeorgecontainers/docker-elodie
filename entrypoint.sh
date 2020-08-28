#!/bin/bash

# Add elodie user
adduser -s /bin/bash -u $PUID -g $PGID -D -g "elodie" elodie && \
    chown -R elodie:elodie /config

# Run elodie as userid elodie with any arguments passed in
exec su-exec elodie /usr/bin/elodie "$@"

