#!/bin/bash

if [ -z ${SNAPSERVER_HOST+x} ]; then
    echo SNAPSERVER_HOST isn\'t set
    exit
fi

if [ -z ${SPOTIFY_CLIENT_ID+x} ] || [ -z ${SPOTIFY_CLIENT_SECRET+x} ]; then
    SPOTIFY_CLIENT_ENABLED="false"
    SPOTIFY_CLIENT_ID=""
    SPOTIFY_CLIENT_SECRET=""
else
    SPOTIFY_CLIENT_ENABLED="true"
fi

# Copy config if it does not already exist
if [ ! -f /etc/mopidy/mopidy.conf ]; then
    mkdir /etc/mopidy
    sed -e "s/{{SNAPSERVER_HOST}}/$SNAPSERVER_HOST/g" -e "s/{{SPOTIFY_CLIENT_ENABLED}}/$SPOTIFY_CLIENT_ENABLED/g" -e "s/{{SPOTIFY_CLIENT_ID}}/$SPOTIFY_CLIENT_ID/g" -e "s/{{SPOTIFY_CLIENT_SECRET}}/$SPOTIFY_CLIENT_SECRET/g" /mopidy_default.conf > /etc/mopidy/mopidy.conf
    chmod 644 /etc/mopidy/mopidy.conf
fi

# if [ ${APK_PACKAGES:+x} ]; then
#     echo "-- INSTALLING APT PACKAGES $APT_PACKAGES --"
#     sudo apt-get update
#     sudo apt-get install -y $APT_PACKAGES
# fi
# if  [ ${PIP_PACKAGES:+x} ]; then
#     echo "-- INSTALLING PIP PACKAGES $PIP_PACKAGES --"
#     pip3 install $PIP_PACKAGES
# fi

exec mopidy --config /etc/mopidy/mopidy.conf "$@"