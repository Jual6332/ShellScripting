#!/bin/bash

# This script creates an account on the local system

# Make sure the script is being executed with superuser privileges.
UID_TO_TEST_FOR='0'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Please run with sudo or as root."
  exit 1
fi

# How many arguments?
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line"

# Make sure that at least one argument is supplied.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# STore username in USER_NAE variable
USER_NAME=${1}
if [[ "${NUMBER_OF_PARAMETERS}" -eq 2 ]]
then
  COMMENT=${2}
else
  COMMENT=""
fi

# Automatically generates a password for the user:
PASS=$(date +%s%N | sha256sum | head -c48)

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The useradd command failed."
  exit 1
fi

# Set the password for the user.
echo ${PASS} | passwd --stdin ${USER_NAME} 

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The passwd command failed."
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo "username:"
echo "${USER_NAME}"
echo "password:"
echo "${PASS}"
echo "host:"
command=$(hostname -f)
echo "${command}"
exit 0
