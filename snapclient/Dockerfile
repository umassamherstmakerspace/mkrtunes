FROM alpine

ENV SNAPSERVER_HOST snapserver

RUN apk add -U snapcast-client
RUN rm -rf /var/cache/apk/*
ENTRYPOINT [ "/usr/bin/snapclient", "-h", "$SNAPSERVER_HOST", "$EXTRA_ARGS" ]