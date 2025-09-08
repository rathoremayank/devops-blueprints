def primeNumbers(n):
    x = 2
    count = 0 
    while(count<n) :
        for i in range(2, int(x ** 0.5) + 1):
            if(x % i == 0):  
                break
        else:
            print(x)
            count += 1
        x += 1

n = int(input("enter n: "))
primeNumbers(n)

# --------------------------------------------------
