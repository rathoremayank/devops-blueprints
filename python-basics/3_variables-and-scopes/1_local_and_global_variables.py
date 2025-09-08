a = "global variable"

def f():
    # global a 
    # a = "testing change in a"
    b = "local variable of function f"
    print("a from inside the function:", a)
    print("b from inside the function:", b)

f()
print("a from outside the function:", a)
# print("b from outside the function:", b)



# note: we use global keyword inside a function if we want to change the global values all through