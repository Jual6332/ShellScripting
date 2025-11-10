#!/bin/bash

# Enforce execution of the script with superuser (root) priviledges.
UID_TO_TEST_FOR='0'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Please run with sudo or as root." >&2
  exit 1
fi


# How many arguments?
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line"

# Make sure that at least one argument is supplied.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
  echo 'Create an account on the local system with the namme of USER_NAME and a comments field of COMMENT.' >&2
  exit 1
fi

# STore username in USER_NAME variable
USER_NAME=${1}
shift
COMMMENT="${@}"

# Automatically generates a password for the user:
PASS=$(date +%s%N | sha256sum | head -c48)

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}
# -m supplies a home directory for the user

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The account could not be created." >&2
  exit 1
fi

# Set the password for the user.
echo ${PASS} | passwd --stdin ${USER_NAME} 

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The password could not be set." >&2
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASS}"
echo
echo "host:"
command=$(hostname -f)
echo "${command}"
exit 0


