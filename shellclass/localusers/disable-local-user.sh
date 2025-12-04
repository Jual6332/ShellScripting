#!/bin/bash
#
# The script disables, deletes, and/or archives users on the local system.

# Must be executed with superuser (root) privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo "Please run this script with sudo or as root." >&2
  exit 1
fi

ARCHIVE_DIR='/archive'

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

if [[ "${#}" -lt 1 ]]
then
  usage
fi

# Loop through all the usernaes supplied as arguments.
for USERNAME in "${@}"
do
  echo "Processing user: ${USERNAME}"
  
  # Make sure the UID of the account is at least 1000.
  USERID=$(id -un ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    echo "Refusing to remove the ${USERNAME} account with the UID ${USERID.}" >&2
    exit 1
  fi
  
  # Create an archive if requested to do so.
  if [[ "${CREATE_ARCHIVE}" = 'true' ]]
  then
    # Make sure the ARCHIVE_DIR directory exists.
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then
      echo "Creating ${ARCHIVE_DIR} directory."
      mkdir -p ${ARCHIVE_DIR}
      if [[ "${?}" -ne 0 ]]
      then
        echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2  
        exit 1
      fi
    fi
    # Make an archive of the user's home dir
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
    if [[ -d "${HOME_DIR}" ]]
    then
      echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
      tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
      if [[ "${?}" -ne 0 ]]
      then
        echo "Could not create ${ARCHIV_FILE}." >&2
        exit 1
      fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
   fi


# Append a special character if requested to do so.
if [[ ${DELETE_ACCOUNT} = 'true' ]]
then
  if [[ ${REMOVE_HOME_DIR} = 'true' ]]
  then
    userdel ${1} -r
  else
    userdel ${1}
  fi
fi

exit 0

# Things I need to work on:
#1. What if a user inputs multiple usernames. Code wont work
#2. When correct arguments are added, the usage statement is still printed. This needs to be fixed.
