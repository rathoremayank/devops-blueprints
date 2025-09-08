# -----------------------------------------------------------------------------------
# simple function

# defining the function
def myPrintFunction():
    print("Hello from function!!!")
    
# calling the function
myPrintFunction()

# -----------------------------------------------------------------------------------
# parametrised function

def myPrintFunctionParams(mystr):
    print(mystr)

myPrintFunctionParams("Yo!!!")


# -----------------------------------------------------------------------------------
# parametrised function with a return
def returningFunctionParams(p,q):
    return(p+q)

print(returningFunctionParams(2,3))