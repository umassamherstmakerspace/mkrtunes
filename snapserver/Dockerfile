FROM alpine:latest

RUN apk add --no-cache musl
RUN rm /etc/apk/repositories && apk add --no-cache snapcast-server dbus avahi avahi-compat-libdns_sd alsa-lib libgcc mpv \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing # We need the latest snapserver

# COPY --from=librespot-build /app/target/release/librespot /usr/bin/librespot
COPY snapserver.conf /etc/snapserver.conf

EXPOSE 1704 1705 1780

ENTRYPOINT /usr/bin/snapserver $EXTRA_ARGS