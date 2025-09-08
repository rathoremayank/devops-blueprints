# A mathematical expression containing +,-,*,^, / and parenthesis will be provided. Read in the expression, then evaluate it. Display the result rounded to  decimal places.
#!/bin/bash

read -r exp
awk "BEGIN { printf \"%.3f\n\", $exp }"