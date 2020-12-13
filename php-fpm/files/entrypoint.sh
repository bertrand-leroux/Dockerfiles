#!/bin/bash
set -e

XDEBUG_PATH=$(grep -rl xdebug "${PHP_INI_DIR}")

function enableXdebug() {
  sudo sed -i 's/^;\+//' "${XDEBUG_PATH}"
}

function disableXdebug() {
  sudo sed -i 's/^;*/;/' "${XDEBUG_PATH}"
}

# Toggle xdebug activation with XDEBUG_ENABLED env var
if [ -n "${XDEBUG_ENABLED}" ]; then
  if [ "${XDEBUG_ENABLED}" == "1" ]; then
    enableXdebug
  elif [ "${XDEBUG_ENABLED}" == "0" ]; then
    disableXdebug
  fi
else
  disableXdebug
fi
eval "${@}"
