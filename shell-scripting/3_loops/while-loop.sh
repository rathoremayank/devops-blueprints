# Print multiplication table of 2
count = 1 
while ((count<=10)); do
    result=$((2 * count))
    echo "2 x $count = $result"
    ((count++))
done