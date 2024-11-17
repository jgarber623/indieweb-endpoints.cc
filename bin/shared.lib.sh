#!/usr/bin/env bash

if [ -z "${SCRIPT_DIR}" ]; then
  log "🚨 SCRIPT_DIR was not defined."
  exit 1
fi

ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

log() {
  echo "[ ${0} ]" "${@}"
}

title() {
  echo -e "\033[1;37m${*}\033[0m"
}
