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

# Bc stands for Bash Calculator

# Calculate 100/3 to 3 decimal places
echo "scale=3;100/3" | bc # This will output 33.333

# Given a circle of dimensions:
d=4.0 #in
pi=3.14159265

# Calculate the circumference of a circle
echo "scale=3;2*$pi*$d/2" | bc # outputs 12.566
# Verified with online calculator: https://www.omnicalculator.com/math/circumference

# Calculate the area of a circle to 3 decimal places
#echo "scale=3;pi*d/2*d/2" | bc # outputs 0, missing $s
echo "scale=3;$pi*$d/2*$d/2" | bc # outputs 12.566
# Verified with online calculator: https://www.omnicalculator.com/math/area-of-a-circle

# Double the user input. Multiply user input by 2
echo "Enter a number to be doubled"
read inputA

var=$((inputA*2))
echo "You entered $inputA. $inputA times 2 equals ... "
echo $var

# How to do the square root of a number 
echo "Enter a number to be square-rooted"
read inputB
echo "scale=0;sqrt($inputB)" | bc

# Numerical Comparison Logic Operators
# Example 1:
x=10
echo "please enter a number greater than but not equal to 10"
read y

if [ $y -lt $x ]
then 
    echo "The number you entered is less than 10, this is incorrect."
elif [ $y -eq $x ]
then 
    echo "The number you entered is equal than 10, this is incorrect."
elif [ $y -gt $x ]
then
    echo "The number you entered is greater than 10, this is correct."
fi

# Example 2:
echo "Enter a number to see if it is even or odd"
read y

remainder=$(($y%2))

if [ $remainder -eq 0 ]
then 
    echo "Even number"
else
    echo "Odd number"
fi

# Add two numbers together
DICEA='3'
DICEB='6'
TOTAL=$(( DICEA + DICEB ))
echo ${TOTAL}

# Increment a value
NUM='1'
(( NUM++ ))
echo ${NUM}

# Decrement a value
NUM='1'
(( NUM-- ))
echo ${NUM}

# Add a value of 5
(( NUM += 5 ))
echo ${NUM}

NUM=$(( NUM += 5 ))
echo ${NUM}

# Use the let command
let NUM='2+3'
echo ${NUM}

let NUM++
echo ${NUM}

# expr syntax
expr 1 + 1
Returns 2
NUM=$(expr 2+3)
echo ${NUM}
returns 5