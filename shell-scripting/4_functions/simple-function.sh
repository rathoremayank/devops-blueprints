# simple function to print a greeting message

print-msg() {
    echo "This is your message - $1"
}

# Call the function
print-msg "Alpha Come in"

add-two-numbers() {
    echo $(($1 + $2))
}

add-two-numbers 5 10

