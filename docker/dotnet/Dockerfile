FROM ghcr.io/fjordock/alpine:3.22.1

ARG TARGETARCH
ARG DOTNET_CHANNEL=10.0

USER root
RUN apk add --no-cache wget bash
    
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel ${DOTNET_CHANNEL} --architecture ${TARGETARCH} --os linux-musl --install-dir /usr/lib/dotnet && \
    ln -s /usr/lib/dotnet/dotnet /usr/bin/dotnet && \
    rm /tmp/dotnet-install.sh

RUN apk del wget bash

WORKDIR /app

USER fjordock

CMD ["/bin/sh"]