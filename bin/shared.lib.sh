if [ -z $SCRIPT_DIR ]; then
  log "🚨 SCRIPT_DIR was not defined."
  exit 1
fi

ROOT_DIR=$(cd -- "${SCRIPT_DIR}/.." > /dev/null 2>&1 && pwd)
COMPOSE_FILE="${ROOT_DIR}"/.devcontainer/docker-compose.yml

log() {
  echo "[ "${0}" ]" "${@}"
}

title() {
  echo -e "\033[1;37m${@}\033[0m"
}

check_for_docker() {
  if ! command -v "docker" > /dev/null 2>&1; then
    log "🚨 Docker is not installed! Download and install Docker by visiting:"
    log ""
    log "  https://www.docker.com/get-started/"
    log ""
    exit 1
  fi
}

run_within_docker() {
  FILE="/.dockerenv"
  BIN_DIR=$(dirname -- "${0}")

  if ! [ -f "${FILE}" ]; then
    log "🚨 The command \"${0}\" must be executed within the running container:"
    log ""
    log "   ${BIN_DIR}/exec ${0} ${@}"
    log ""

    read -p "[ "${0}" ] ♻️  Re-execute the command within the running container? [y/N] " yn

    shopt -s nocasematch

    if [ "${yn}" = "y" ]; then
      "${BIN_DIR}"/exec $0 $@
      exit
    else
      exit 1
    fi
  fi
}
