FROM alpine:latest

LABEL author="cyl3x" maintainer="Pterodactyl Software, <support@pterodactyl.io>"

RUN apk add --no-cache --update curl jq ca-certificates openssl git tar bash sqlite fontconfig tzdata iproute2 \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./FalloutTogetherServer /home/container/FalloutTogetherServer

EXPOSE 10578/udp

CMD ["/bin/bash", "/entrypoint.sh"]
