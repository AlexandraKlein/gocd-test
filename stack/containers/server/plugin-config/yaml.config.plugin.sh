#!/usr/bin/env bash

curl "${GOCD_CONFIG_URL}/go/api/admin/plugin_settings" \
  -u "${GOCD_USER}:${GOCD_PASSWORD}" \
  -H 'Accept: application/vnd.go.cd.v1+json' \
  -H 'Content-Type: application/json' \
  -X POST \
  -d "{
    \"plugin_id\": \"yaml.config.plugin\",
    \"configuration\": [
      {
        \"key\": \"file_pattern\",
        \"value\": \"**/ci/*.yml\"
      }
    ]
  }"
