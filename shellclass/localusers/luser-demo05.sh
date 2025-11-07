#!/bin/bash

#echo "New script!"

# This script generates a list of random passwords.

PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Combine three random numbers into one password.
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use epoch time (current ie since 1970-01-01) as basis for the password.
PASSWORD=$(date +%s%N)
echo ${PASSWORD}

#A better password. 
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# An even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

#Append a special char
SPECIAL_CHAR=$(echo '!@#$%^&*()_-+='| fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHAR}"
