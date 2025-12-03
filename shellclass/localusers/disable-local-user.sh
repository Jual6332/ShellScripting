#!/bin/bash
#
# The script disables, deletes, and/or archives users on the local system.

# Must be executed with superuser (root) privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo "Please run this script with sudo or as root." >&2
  exit 1
fi

usage(){
  echo "Usage: ${0} [-dra] USER [USERN]..." >&2
  echo 'Disabled a local Linux account.' >&2
  echo '  -d   Deletes accounts instead of disabling them.'>&2
  echo '  -r   Removes the home directory associated with the account(s).'>&2
  echo '  -a   Creates an archive of the home directory associated with the account.'>&2
  exit 1
}

while getopts dra OPTION
do
  case ${OPTION} in
    d)
      DELETE_ACCOUNT='true'
      ;;
    r)
      REMOVE_HOME_DIR='true'
      ;;
    a)
      CREATE_ARCHIVE='true'
      ;;
    ?)
      echo 'Invalid option.' >&2
      usage
      exit 1
      ;;
   esac
done

# Inspect OPTIIND
echo "OPTIND: ${OPTIND}"

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
  usage
fi

# Append a special character if requested to do so.
if [[ ${DELETE_ACCOUNT} = 'true' ]]
then
  if [[ ${REMOVE_HOME_DIR} = 'true' ]]
  then
    if [[ ${CREATE_ARCHIVE} = 'true' ]]
    then
      mkdir archives
      NAME='home_'+${1}+'_archive'
      #tar -cf home   
    fi
    userdel ${1} -r
  else
    userdel ${1}
  fi
fi

exit 0

# Things I need to work on:
#1. What if a user inputs multiple usernames. Code wont work
#2. When correct arguments are added, the usage statement is still printed. This needs to be fixed.
