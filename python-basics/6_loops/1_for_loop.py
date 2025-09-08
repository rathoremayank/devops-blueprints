# n = 5 
# for i in range(0,n): 
#     print(2*i)
    
    
mylist = ["Hi!", "I" , "am", "Mayank"]
for i in mylist:
    print(i)
    
myString = "Mayank"
for i in myString:
    print(i)
    
# iterating by list index

mylist = ["Hi!", "I" , "am", "Mayank"]
for i in range(len(mylist)):
    print(mylist[i])
    
# for with else

mylist = ["Hi!", "I" , "am", "Mayank"]
for i in range(len(mylist)):
    print(mylist[i])
else:
    print("inside for else")