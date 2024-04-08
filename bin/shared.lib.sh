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

run_within_docker() {
  FILE="/.dockerenv"

  if ! [ -f "${FILE}" ]; then
    log "🚨 The command \"${0}\" must be run within the Dev Container."
    log ""
    log "Launch the Dev Container, open a Visual Studio Code Terminal, and re-run the command."
    log ""
    exit 1
  fi
}
