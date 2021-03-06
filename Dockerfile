FROM alpine

WORKDIR /data

RUN apk -U add cargo libasound2-dev pkg-config \
 && cd /root \
 && cargo install librespot \
 && mkfifo /data/fifo

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_DEVICE /data/fifo

CMD librespot -n "$SPOTIFY_NAME" --backend "$LIBRESPOT_BACKEND" --device "$SPOTIFY_DEVICE"
