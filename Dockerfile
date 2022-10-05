FROM alpine

WORKDIR /data

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_DEVICE /data/fifo

RUN apk -U add curl cargo alsa-lib-dev \
 && cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/master.zip \
 && unzip master.zip \
 && cd librespot-master \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
 && mv target/release/librespot /usr/local/bin \
 && mkfifo $SPOTIFY_DEVICE \
 && apk add llvm-libunwind

CMD librespot -n "$SPOTIFY_NAME" --backend "$LIBRESPOT_BACKEND" --device "$SPOTIFY_DEVICE" --zeroconf-port 3112 --device-type "$SPOTIFY_DEVICETYPE" -u "$SPOTIFY_USERNAME" -p "$SPOTIFY_PASSWORD"
