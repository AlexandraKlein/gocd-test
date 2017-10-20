#!/usr/bin/env bash

source ./bin/tools/functions.sh
source ./bin/tools/build.sh

sh ./bin/tools/check-keys.sh

coloredEcho "<<< ($BASH_SOURCE) Creating Key Symlinks" green

abs_stack_path=$(get_full_path "./stack")

if [[ ! -L "${abs_stack_path}/containers/server/keys" && ! -d "${abs_stack_path}/containers/server/keys" ]]; then
  cp -r "${abs_stack_path}/keys" "${abs_stack_path}/containers/server/keys"
fi

if [[ ! -L "${abs_stack_path}/containers/agent/keys" && ! -d "${abs_stack_path}/containers/agent/keys" ]]; then
  cp -r "${abs_stack_path}/keys" "${abs_stack_path}/containers/agent/keys"
fi

coloredEcho "<<< ($BASH_SOURCE) Creating combined .env file" green

# Combine .env files
cat .env.insecure > .env
cat .env.secure >> .env

# Prep before build

coloredEcho "<<< ($BASH_SOURCE) Downloading Plugins" green

sh ./bin/gocd/get-plugins.sh

result=$?
exit_on_error ${result} "<<< Failed to download plugins"

coloredEcho "<<< ($BASH_SOURCE) Creating Templates" green

sh ./bin/gocd/config-templates.sh

result=$?
exit_on_error ${result} "<<< Failed configure templates"

# Build images
build_images

result=$?
exit_on_error ${result} "<<< Failed to build images"
