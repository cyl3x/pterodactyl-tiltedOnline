ARG project

FROM server:builder AS builder

FROM scratch AS skyrim
COPY --from=builder /home/server/Build/bin/x64/SkyrimTogetherServer /SkyrimTogetherServer
ENTRYPOINT ["/SkyrimTogetherServer"]

FROM scratch AS fallout4
COPY --from=builder /home/server/Build/bin/x64/FalloutTogetherServer /FalloutTogetherServer
ENTRYPOINT ["/FalloutTogetherServer"]

FROM ${project} AS final

FROM final

LABEL author="cyl3x" maintainer="Pterodactyl Software, <support@pterodactyl.io>"

RUN apk add --no-cache --update curl jq ca-certificates openssl git tar bash sqlite fontconfig tzdata iproute2 \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
RUN mv /FalloutTogetherServer /home/container/FalloutTogetherServer
RUN mv /SkyrimTogetherServer /home/container/SkyrimTogetherServer

EXPOSE 10578/udp

CMD ["/bin/bash", "/entrypoint.sh"]
