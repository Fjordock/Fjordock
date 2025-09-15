FROM scratch

# Add the appropriate minirootfs for the target architecture
ARG TARGETARCH
ARG TARGETVARIANT

ADD ./docker/alpine/alpine-minirootfs-3.22.1-${TARGETARCH}${TARGETVARIANT:+-$TARGETVARIANT}.tar.gz /

ENV TZ=Etc/UTC LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ca-certificates tzdata icu-libs icu-data-full && \
    addgroup -Sg 1000 fjordock && \
    adduser -Sg 1000 -G fjordock -h /app -g "fjordock" -s /bin/sh fjordock

# Copy the appropriate templater binary
COPY ./docker/alpine/linux/${TARGETARCH}${TARGETVARIANT:+/$TARGETVARIANT}/templater /usr/local/bin/templater

RUN chmod 0755 /usr/local/bin/templater

WORKDIR /app
USER fjordock

CMD ["/bin/sh"]