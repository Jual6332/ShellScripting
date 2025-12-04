#!/bin/bash
#
# This script disables, deletes, and/or archives users on the local system.

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
# Debugging purposes:
#echo "OPTIND: ${OPTIND}"

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
    echo "Refusing to remove the ${USERNAME} account with the UID of ${USERID}." >&2 
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
  
  if [[ "${DELETE_ACCOUNT}" = 'true' ]]
  then
    # Delete the user
    if [[ ${REMOVE_HOME_DIR} = 'true' ]]
    then
      userdel -r ${USERNAME}
    else
      userdel ${USERNAME}
    fi
    
    # CHeck to see if the userdel command succeeded.
    # We don't want to tell the user the account was deleted when it wasn't.
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT deleted." >&2
      exit 1
    else
      echo "The account ${USERNAME} WAS deleted."
    fi
  else
    chage -E 0 ${USERNAME}
    # CHeck to see if the chage command succeeded.
    # We don't want to tell the user the account was disabled when it wasn't.
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT disabled." >&2
      exit 1
    else
      echo "The account ${USERNAME} WAS disabled."
    fi
  fi
done


exit 0


