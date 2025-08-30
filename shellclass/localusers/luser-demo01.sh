#!/bin/bash
# Author: Justin Alvey
# This script displays various information to the screen.

# Display 'Hello'
echo 'Hello'

# Assign a value to a variable
WORD='This script has completed running.'
WORD2='script'

# Display variable value to the screen
echo "$WORD"

# Demonstrate that single quotes cause variable values not to get displayed to the screen
echo '$WORD'

# Combine words and variable strings into one
echo "This is a shell $WORD2."

# Display the contents of the variable string usiing alternative syntax
echo "This is a shell ${WORD2}."

# Append text to variable
echo "${WORD2}ing is fun!"

# Show how NOT to appencd text to variable
# This will not work:
echo "$WORD2ing is fun!"
# This variable doesn't exist so it doesn't expand to anything

# Create new variable
ENDING='ed'

echo "This is ${WORD2}${ENDING}."

# Reassign value of variable ENDING
ENDING='ing'

echo "${WORD2}${ENDING} is fun!"

