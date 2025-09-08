# Given three integers (, , and ) representing the three sides of a triangle, identify whether the triangle is scalene, isosceles, or equilateral.

# If all three sides are equal, output EQUILATERAL.
# Otherwise, if any two sides are equal, output ISOSCELES.
# Otherwise, output SCALENE.

read num1
read num2
read num3

if ((num1 == num2 && num2 == num3)); then 
    echo "EQUILATERAL"
elif ((num1 == num2 || num2 == num3 || num1 == num3)); then
    echo "ISOSCELES"
else
    echo "SCALENE"
fi