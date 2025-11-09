#!/bin/bash

# Script 6

# This script generates a random password for each user specified on the command line.

# Display what the user typed on the command line.
echo "You executed this command: ${0}"

# Display the path and filename of the script.
fileName=$(basename ${0})
path=$(dirname ${0})

echo "Filename is: ${fileName}"
echo "Directory path is ${path}"

# How many arguments?
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line"

# Make sure that at least one argument is supplied.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# Implement for loop to display greeting to 3 people
for X in Frank Claire Doug
do
  echo "${X}"
done

# Generate and display a password for each parameter
for USER_NAME in "${@}"
do
  PASSWORD=$(date +%s%N | sha256sum | head -c48)
  echo "${USER_NAME}: ${PASSWORD}"
done

# User can input 1,2,or 10 usernames and ${@} will handle it.

