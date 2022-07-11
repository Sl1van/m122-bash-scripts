#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

FILE_NOT_FOUND=240


function handle_exit() {
    echo "exiting cleanly...."
    exit 1
}

trap handle_exit 0 SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

function __msg_error() {
    [[ "${ERROR}" == "1" ]] && echo -e "[ERROR]: $*"
}

function __msg_debug() {
    [[ "${DEBUG}" == "1" ]] && echo -e "[DEBUG]: $*"
}

function __msg_info() {
    [[ "${INFO}" == "1" ]] && echo -e "[INFO]: $*"
}

function read_file() {
  if ls imnotexisting; then
    __msg_error "File not found"
    return ${FILE_NOT_FOUND}
  fi
}

