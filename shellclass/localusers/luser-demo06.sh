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
