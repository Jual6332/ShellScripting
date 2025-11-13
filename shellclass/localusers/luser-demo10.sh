#!/bin/bash

log() {
  # This function sends a message to syslog and to standard output if VERBOSE is true.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

# Functions have to be defined before they can be used.
backup_file(){
  # This function creates a backup of a file. Returns non-zero status on error.
  local FILE="${1}"
  # make sure the file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command.
    cp -p ${FILE} ${BACKUP_FILE} #-p flag saves the original timestamp of the file
  else
    # The file does not exist, so return a non-zero exit status.
    return 1
  fi
}

# Files in /var/tmp will survive a reboot. But files in /tmp will not

readonly VERBOSE='true'
log 'Hello there'
log 'This is fun!'

backup_file '/etc/passwd'

# make a decision based on the exit status of the function.
if [[ "${?}" -eq 0 ]]
then
  log "File backup succeeded."
else
  log 'File backup failed!'
  exit 1
fi

# Review:
# DRY - Dont Repeat Yourself
# All variables are global in scope
# Local variables are only available in the function they are defined in
# Use return command to return exit statuses
