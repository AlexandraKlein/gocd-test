#!/usr/bin/env bash

export $(cat .env | xargs)

source ./stack/containers/server/plugin-config/github-oauth-login.sh
source ./stack/containers/server/plugin-config/yaml.config.plugin.sh
