#!/bin/bash

# This file will be used for studying arithetic in Bash scripting.

# Add 2+2 and print to the command line
sum_four=$((2+2))
echo $sum_four

# How do I round my math output to 2 decimmal places?
echo "scale=2;22/7" | bc # This outputs 3.14

expre=$((22/7))
echo "scale=2;$expre" | bc # This outputs 3

# How do I round my math output to 2 decimmal places?
echo "scale=3;22/7" | bc # This outputs 3.142