FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    python3-dev \
    gstreamer \
    mopidy \
    py-pip \
    alpine-sdk \
    python3-dev\
    dumb-init \
    curl

RUN python3 -m venv /venv && . /venv/bin/activate \
    && pip3 install \
    Mopidy \
    Mopidy-MPD \
    Mopidy-Local \
    Mopidy-TuneIn \
    Mopidy-YTMusic \
    Mopidy-Spotify \
    Mopidy-Iris

COPY mopidy_default.conf /mopidy_default.conf
COPY mopidy.sh /mopidy.sh
RUN chmod +x /mopidy.sh

EXPOSE 6600 6680
ENTRYPOINT ["/mopidy.sh"]