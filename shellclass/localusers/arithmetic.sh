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
