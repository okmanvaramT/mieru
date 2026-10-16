#!/bin/bash
set -euo pipefail

: "${MIERU_USER:?Set MIERU_USER in Railway Variables}"
: "${MIERU_PASSWORD:?Set MIERU_PASSWORD in Railway Variables}"

cat > /tmp/server.json <<EOF
{
  "portBindings": [
    {
      "port": 8443,
      "protocol": "TCP"
    }
  ],
  "users": [
    {
      "name": "${MIERU_USER}",
      "password": "${MIERU_PASSWORD}"
    }
  ],
  "loggingLevel": "INFO",
  "mtu": 1400,
  "dns": {
    "dualStack": "PREFER_IPv4"
  }
}
EOF

mkdir -p /var/run/mita
export MITA_CONFIG_JSON_FILE=/tmp/server.json

exec mita run
