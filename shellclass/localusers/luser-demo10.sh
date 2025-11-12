#!/bin/bash

log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

readonly VERBOSE='true'
log 'Hello there'
log 'This is fun!'



