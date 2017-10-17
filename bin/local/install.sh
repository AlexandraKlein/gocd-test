#!/usr/bin/env bash

source ./bin/tools/functions.sh

sh ./bin/tools/check-keys.sh

abs_stack_path=$(get_full_path "./stack")

if [ ! -L "${abs_stack_path}/containers/server/keys" ]; then
  cp -r "${abs_stack_path}/keys" "${abs_stack_path}/containers/server/keys"
fi

if [ ! -L "${abs_stack_path}/containers/agent/keys" ]; then
  cp -r "${abs_stack_path}/keys" "${abs_stack_path}/containers/agent/keys"
fi

docker-compose build
