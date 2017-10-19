#!/usr/bin/env bash

source ./bin/tools/functions.sh

PLUGIN_PATH="./stack/containers/server/plugins"

PLUGINS=(
  "ashwanthkumar/gocd-slack-build-notifier:v1.4.0-RC10/gocd-slack-notifier-1.4.0-RC10.jar"
  "ashwanthkumar/gocd-build-github-pull-requests:v1.3.4/github-pr-poller-1.3.4.jar"
  "gocd-contrib/gocd-oauth-login:v2.4/github-oauth-login-2.4.jar"
  "gocd-contrib/gocd-build-status-notifier:1.3/github-pr-status-1.3.jar"
)

find ${PLUGIN_PATH} -name "*.jar" -exec rm -f {} \;

for plugin in "${PLUGINS[@]}"
do
  REPO=$(echo ${plugin} | awk -F':' '{print $1}')
  ASSET=$(echo ${plugin} | awk -F':' '{print $2}')

  wget -q \
      https://github.com/${REPO}/releases/download/${ASSET} -O ${PLUGIN_PATH}/$(echo ${ASSET} | awk -F'/' '{print $2}')
done
