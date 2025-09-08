# Given  integers, compute their average, rounded to three decimal places.

# Input Format
# The first line contains an integer, .
# Each of the following  lines contains a single integer.

# Output Format
# Display the average of the  integers, rounded off to three decimal places.

#!/bin/bash
read -r n
sum=0
for ((i=0; i<n; i++)); do
    read -r num
    sum=$((sum + num))
done
avg=$(echo "scale=3; $sum / $n" | bc)
printf "%.3f\n" "$avg"