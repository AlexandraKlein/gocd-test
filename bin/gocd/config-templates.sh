#!/usr/bin/env bash

source ./bin/tools/functions.sh

export $(cat .env | xargs)

mustache -v >/dev/null 2>&1 || {
  coloredEcho "<<< ($BASH_SOURCE) Requires mustache https://github.com/janl/mustache.js/" red
  exit 1
}

coloredEcho "<<< ($BASH_SOURCE) Creating GoCD Slack Config" green

echo "{}" | \
  mustache - ./stack/containers/server/templates/go_notify.conf.mustache > ./stack/containers/server/config/go_notify.conf

result=$?
exit_on_error ${result} "<<< Failed to build template"

coloredEcho "<<< ($BASH_SOURCE) Creating GoCD Cruise Config" green

echo "{
    \"REPO\": \"${REPO}\",
    \"SITE_URL\": \"${SITE_URL}\",
    \"SITE_URL_SECURE\": \"${SITE_URL_SECURE}\"
  }" | \
  mustache - ./stack/containers/server/templates/cruise-config.xml.mustache > ./stack/containers/server/config/cruise-config.xml

result=$?
exit_on_error ${result} "<<< Failed to build template"
