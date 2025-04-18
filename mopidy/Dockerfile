FROM alpine:latest as librespot-build
WORKDIR /app
RUN apk -U add git build-base cargo alsa-lib-dev
RUN git clone --depth 1 --branch v0.4.1 https://github.com/librespot-org/librespot.git .
RUN cargo build --release --features alsa-backend

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

COPY --from=librespot-build /app/target/release/librespot /usr/bin/librespot

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