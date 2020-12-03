FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN ( \
        apt-get update && \
        apt-get install -y gnupg \
    )

RUN ( \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C208ADDE26C2B797 && \
        ( echo "deb http://downloads.linux.HPE.com/SDR/repo/mcp/ buster/current non-free" > /etc/apt/sources.list.d/proliant.sources.list ) && \
        apt-get update && \
        apt-get install -y ssa curl\
    )

# Apply the s6-overlay
RUN curl -SLO "https://github.com/just-containers/s6-overlay/releases/download/v1.20.0.0/s6-overlay-amd64.tar.gz" \
  && tar -xzf s6-overlay-amd64.tar.gz -C / \
  && tar -xzf s6-overlay-amd64.tar.gz -C /usr ./bin \
  && rm -rf s6-overlay-amd64.tar.gz

COPY rootfs /

ENTRYPOINT [ "/init" ]
