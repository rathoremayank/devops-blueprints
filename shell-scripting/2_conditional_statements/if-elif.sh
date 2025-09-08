# Find largest amount among three numbers

echo "Enter three numbers: "
read num1
read num2
read num3

if ((num1 > num2 && num1 > num3)); then 
    echo "Print $num1 is largest"
elif ((num2 > num1 && num2 > num3)); then
    echo "Print $num2 is largest"
elif ((num3 > num1 && num3 > num2)); then
    echo "Print $num3 is largest"
else
    echo "Ambiguous!!!"
fi

