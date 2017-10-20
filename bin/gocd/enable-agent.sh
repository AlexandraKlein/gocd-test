#!/usr/bin/env bash

source ./bin/tools/functions.sh

export $(cat .env | xargs)

coloredEcho "<<< ($BASH_SOURCE) Getting all GoCD Agents" green

# Get Agents
AGENTS_RESPONSE=$(curl -sS "${GOCD_CONFIG_URL}/go/api/agents" \
  -u "${GOCD_USER}:${GOCD_PASSWORD}" \
  -H 'Accept: application/vnd.go.cd.v4+json' \
  -H 'Content-Type: application/json')

AGENTS=$(node -pe 'JSON.parse(process.argv[1])._embedded.agents.map(agent => agent.uuid).join(", ")' "${AGENTS_RESPONSE}")

coloredEcho "<<< ($BASH_SOURCE) Enabling all GoCD Agents" green

# TODO: When multiple agents work will need to be done before the CURL

# Enable all agents
curl "${GOCD_CONFIG_URL}/go/api/agents" \
  -u "${GOCD_USER}:${GOCD_PASSWORD}" \
  -H 'Accept: application/vnd.go.cd.v4+json' \
  -H 'Content-Type: application/json' \
  -X PATCH \
  -d "{
    \"uuids\": [\"${AGENTS}\"],
    \"agent_config_state\" : \"enabled\"
  }"
