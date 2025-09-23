#!/bin/bash

# This script creates an account on the local system

# Make sure the script is being executed with superuser privileges.
UID_TO_TEST_FOR='0'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Please run with sudo or as root."
  exit 1
fi

# Ask for the user name.
read -p 'Enter the username for account: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account belongs to: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASS

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