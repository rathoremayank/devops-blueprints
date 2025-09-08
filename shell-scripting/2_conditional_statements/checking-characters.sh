# Read in one character from STDIN.
# If the character is 'Y' or 'y' display "YES".
# If the character is 'N' or 'n' display "NO".
# No other character will be provided as input.

read input

# 1. String comparison with single brackets [ ... ]
if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
    echo "YES"
elif [ "$input" = "N" ] || [ "$input" = "n" ]; then
    echo "NO"
fi

# 2. Pattern matching with double brackets [[ ... ]]
if [[ "$input" == [Yy] ]]; then
    echo "YES"
elif [[ "$input" == [Nn] ]]; then
    echo "NO"
fi


# 3. Regular expression matching with double brackets [[ ... ]]
if [[ $input =~ [Yy] ]]; then 
    echo "YES" 
else 
    echo "NO" 
fi