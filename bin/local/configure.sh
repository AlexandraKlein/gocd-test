#!/usr/bin/env bash

source ./bin/tools/functions.sh

sh ./bin/gocd/configure-plugins.sh
sh ./bin/gocd/enable-agent.sh
