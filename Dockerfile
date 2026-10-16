
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fL \
    https://github.com/enfein/mieru/releases/download/v3.38.0/mita_3.38.0_amd64.deb \
    -o /tmp/mita.deb \
    && apt-get update \
    && apt-get install -y /tmp/mita.deb \
    && rm -f /tmp/mita.deb \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
