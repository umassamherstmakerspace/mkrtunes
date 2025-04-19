FROM alpine:latest
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

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
    gst-plugins-rs-spotify \
    curl


RUN python3 -m pip install --no-cache-dir --break-system-packages \
    pylast \
    mopidy==4.0.0a4 \
    Mopidy-Mowecl==0.6.1-a5 \
    Mopidy-Spotify==5.0.0a4 \
    Mopidy-MPD==4.0.0a1

COPY mopidy_default.conf /mopidy_default.conf
COPY mopidy.sh /mopidy.sh
RUN chmod +x /mopidy.sh

EXPOSE 6600 6680
ENTRYPOINT ash /mopidy.sh