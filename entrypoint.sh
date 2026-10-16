
#!/bin/sh
set -eu

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

export MITA_CONFIG_JSON_FILE=/tmp/server.json
mita replace config /tmp/server.json
mita start
