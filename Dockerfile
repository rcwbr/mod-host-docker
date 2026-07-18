# hadolint ignore=DL3006
FROM base_context

FROM python:3.10.20 AS builder

RUN apt-get update && apt-get install --no-install-recommends -y \
    lv2-dev=1.18.10* \
    libjack-jackd2-dev=1.9.22* \
    liblilv-dev=0.24.26* \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/cache/debconf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/mod-host
RUN --mount=type=bind,from=github-mod-host,target=.,rw \
    make \
    && make install


FROM python:3.10.20 AS runtime

RUN apt-get update && apt-get install --no-install-recommends -y \
    dbus-daemon=1.16.2* \
    jackd2=1.9.22* \
    libjack-jackd2-dev=1.9.22* \
    liblilv-0-0=0.24.26* \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/cache/debconf \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/mod-host /usr/local/bin/mod-host

COPY entrypoint /entrypoint

ENTRYPOINT [ "/entrypoint" ]
