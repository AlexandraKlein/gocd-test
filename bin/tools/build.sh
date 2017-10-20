#! /bin/bash

source ./bin/tools/functions.sh

build_images() {
  local result
  local BASE=$(pwd)

  coloredEcho "Building containers with Docker Compose" green
  docker-compose build

  result=$?
  exit_on_error ${result} "<<< Failed to build docker images"

  coloredEcho "Starting containers" green

  # Spin up containers
  coloredEcho "Composing" green
  docker-compose up -d

  # Wait for things to finish
  coloredEcho "Waiting a few minutes ..." yellow
  sleep 90

  coloredEcho "Running post install on container" green

  # Run post config
  sh ./bin/gocd/configure-plugins.sh
  cd "${BASE}"

  coloredEcho "Cleanup" green

  # Spin down containers
  docker-compose down
}
