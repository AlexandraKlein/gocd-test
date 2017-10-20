#!/usr/bin/env bash

curl "${GOCD_CONFIG_URL}/go/api/admin/plugin_settings" \
  -u "${GOCD_USER}:${GOCD_PASSWORD}" \
  -H 'Accept: application/vnd.go.cd.v1+json' \
  -H 'Content-Type: application/json' \
  -X POST -d "{
    \"plugin_id\": \"github.oauth.login\",
    \"configuration\": [
      {
        \"key\": \"server_base_url\",
        \"value\": \"${SITE_URL_SECURE}\"
      },
      {
        \"key\": \"consumer_key\",
        \"value\": \"${GITHUB_CLIENT_ID}\"
      },
      {
        \"key\": \"consumer_secret\",
        \"value\": \"${GITHUB_CLIENT_SECRET_KEY}\"
      }
    ]
  }"
