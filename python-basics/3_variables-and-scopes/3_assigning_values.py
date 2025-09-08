# assigning same value to multiple variables 
a = b = c = 5 

print(a)
print(b)
print(c)


# swapping variable values 
x = 2 
y = 4 
print("before x: ", x)
print("before y: ", y)

x, y = y, x 

print("after x: ", x)
print("after y: ", y)


# assigning multiple values at the same time
p, q, r = 4, 5, "hello"
print(p,q,r) 