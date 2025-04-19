FROM alpine:latest as gst-rs-build
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
WORKDIR /build

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    git \
    musl-dev \
    pkgconfig \
    build-base \
    openssl-dev \
    cargo-c \
    glib-dev \
    gstreamer-dev \
    rust \
    cargo
RUN git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git .
RUN cargo cbuild -p gst-plugin-spotify --prefix=/usr --library-type staticlib --library-type cdylib
RUN cargo cinstall -p gst-plugin-spotify --prefix=/usr --library-type staticlib --library-type cdylib

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
    pkgconfig \
    openssl-dev \
    curl

COPY --from=gst-rs-build /usr/lib/gstreamer-1.0/libgstspotify.so /usr/lib/gstreamer-1.0/libgstspotify.so
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