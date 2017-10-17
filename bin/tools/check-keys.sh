#! /bin/bash

source ./bin/tools/functions.sh

if [ ! -f "./stack/keys/id_rsa" ]; then
  exit_on_error 1 "<<< ($BASH_SOURCE) Unable to configure SSH, please create a (id_rsa) file in ./stack/keys"
fi

if [ ! -f "./stack/keys/id_rsa.pub" ]; then
  exit_on_error 1 "<<< ($BASH_SOURCE) Unable to configure SSH, please create a (id_rsa.pub) file in ./stack/keys"
fi
