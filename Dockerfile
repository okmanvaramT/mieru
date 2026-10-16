
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl tar bash \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fL \
    https://github.com/enfein/mieru/releases/download/v3.38.0/mita_3.38.0_linux_amd64.tar.gz \
    -o /tmp/mita.tar.gz \
    && mkdir -p /tmp/mita-extract \
    && tar -xzf /tmp/mita.tar.gz -C /tmp/mita-extract \
    && install -m 0755 "$(find /tmp/mita-extract -type f -name mita -print -quit)" /usr/local/bin/mita \
    && rm -rf /tmp/mita.tar.gz /tmp/mita-extract

RUN groupadd --system mita \
    && useradd --system --gid mita --home-dir /var/lib/mita --create-home --shell /usr/sbin/nologin mita \
    && mkdir -p /var/run/mita \
    && chown mita:mita /var/run/mita /var/lib/mita

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
