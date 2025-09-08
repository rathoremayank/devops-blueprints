# User input a number and print whether it is even or odd

echo "Enter a number:"
read number

# Note: Using double parentheses for arithmetic evaluation
if (( number % 2 == 0 )); then
    echo "$number is even."
else
    echo "$number is odd."
fi

# Can also use single brackets with -eq for equality check
if [ $(( number % 2 )) -eq 0 ]; then
    echo "$number is even."
else
    echo "$number is odd."
fi
