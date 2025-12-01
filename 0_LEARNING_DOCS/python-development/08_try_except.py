
a = int(input("enter a: "))
b = int(input("enter b: "))


try:

    c = a/b
    print(c)
except ZeroDivisionError:
    print("Division by 0 is not allowed")
except ValueError:
    print("Enter integers only")