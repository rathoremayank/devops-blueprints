# Python Programming Syntax

This document provides a comprehensive overview of Python programming syntax, including examples and scenario-based interview questions with answers for each topic.

## Table of Contents
1. Introduction to Python
2. Variables and Data Types
3. Operators
4. Control Flow (if, else, elif)
5. Loops (for, while)
6. Functions
7. Classes and Objects
8. Exception Handling
9. Modules and Packages
10. File I/O
11. List Comprehensions
12. Lambda Functions
13. Decorators
14. Generators
15. Context Managers
16. Regular Expressions
17. Working with JSON
18. Date and Time
19. Virtual Environments
20. Useful Built-in Functions

---

## 1. Introduction to Python
Python is a high-level, interpreted programming language known for its simplicity and readability. It is widely used in web development, data science, automation, and more.

**Example:**
```python
print("Hello, World!")
```

### Interview Questions
1. **Q:** What are the key features of Python?
   **A:** Easy syntax, interpreted, dynamically typed, extensive libraries, cross-platform.
2. **Q:** How is Python different from other languages?
   **A:** Readability, indentation-based blocks, dynamic typing.
...existing questions...

## 2. Variables and Data Types
Variables store data. Python supports types like int, float, str, bool, list, tuple, dict, set.

**Example:**
```python
x = 10        # int
y = 3.14      # float
name = "Alice" # str
is_valid = True # bool
```

### Interview Questions
1. **Q:** How do you declare a variable in Python?
   **A:** By assigning a value: `x = 5`
2. **Q:** What is dynamic typing?
   **A:** Variable types are determined at runtime.
...existing questions...

## 3. Operators
Python supports arithmetic, comparison, logical, assignment, bitwise, and membership operators.

**Example:**
```python
a = 5
b = 2
print(a + b)  # 7
print(a > b)  # True
print(a == b) # False
```

### Interview Questions
1. **Q:** What is the difference between `==` and `is`?
   **A:** `==` compares values, `is` compares identities.
...existing questions...

## 4. Control Flow (if, else, elif)
Control flow statements direct the execution path.

**Example:**
```python
x = 10
if x > 5:
    print("x is greater than 5")
elif x == 5:
    print("x is 5")
else:
    print("x is less than 5")
```

### Interview Questions
1. **Q:** How does Python handle indentation?
   **A:** Indentation defines code blocks.
...existing questions...

## 5. Loops (for, while)
Loops repeat code blocks.

**Example:**
```python
for i in range(3):
    print(i)

count = 0
while count < 3:
    print(count)
    count += 1
```

### Interview Questions
1. **Q:** What is the difference between `for` and `while` loops?
   **A:** `for` is used for iterables, `while` for conditions.
...existing questions...

## 6. Functions
Functions organize code into reusable blocks.

**Example:**
```python
def greet(name):
    return f"Hello, {name}!"

print(greet("Bob"))
```

### Interview Questions
1. **Q:** What is a lambda function?
   **A:** An anonymous function defined with `lambda`.
...existing questions...

## 7. Classes and Objects
Python supports object-oriented programming.

**Example:**
```python
class Dog:
    def __init__(self, name):
        self.name = name
    def bark(self):
        print(f"{self.name} says woof!")

my_dog = Dog("Rex")
my_dog.bark()
```

### Interview Questions
1. **Q:** What is `self` in a class?
   **A:** Refers to the instance of the class.
...existing questions...

## 8. Exception Handling
Exceptions handle errors gracefully.

**Example:**
```python
try:
    x = 1 / 0
except ZeroDivisionError:
    print("Cannot divide by zero!")
finally:
    print("Done.")
```

### Interview Questions
1. **Q:** What is the purpose of `finally`?
   **A:** Executes code regardless of exceptions.
...existing questions...

## 9. Modules and Packages
Modules organize code; packages are collections of modules.

**Example:**
```python
import math
print(math.sqrt(16))
```

### Interview Questions
1. **Q:** How do you import a module?
   **A:** Using `import module_name`.
...existing questions...

## 10. File I/O
Python reads and writes files easily.

**Example:**
```python
with open("test.txt", "w") as f:
    f.write("Hello!")
```

### Interview Questions
1. **Q:** What does `with open()` do?
   **A:** Manages file context automatically.
...existing questions...

## 11. List Comprehensions
Concise way to create lists.

**Example:**
```python
squares = [x*x for x in range(5)]
```

### Interview Questions
1. **Q:** What is a list comprehension?
   **A:** A compact way to create lists.
...existing questions...

## 12. Lambda Functions
Anonymous functions for short operations.

**Example:**
```python
add = lambda x, y: x + y
print(add(2, 3))
```

### Interview Questions
1. **Q:** Where are lambda functions used?
   **A:** In places where a small function is needed.
...existing questions...

## 13. Decorators
Modify functions or methods.

**Example:**
```python
def my_decorator(func):
    def wrapper():
        print("Before function")
        func()
        print("After function")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

say_hello()
```

### Interview Questions
1. **Q:** What is a decorator?
   **A:** A function that modifies another function.
...existing questions...

## 14. Generators
Functions that yield values one at a time.

**Example:**
```python
def count_up_to(n):
    count = 1
    while count <= n:
        yield count
        count += 1

for num in count_up_to(3):
    print(num)
```

### Interview Questions
1. **Q:** What does `yield` do?
   **A:** Returns a value and pauses the function.
...existing questions...

## 15. Context Managers
Manage resources efficiently.

**Example:**
```python
with open("file.txt") as f:
    data = f.read()
```

### Interview Questions
1. **Q:** What is a context manager?
   **A:** An object that manages resources using `__enter__` and `__exit__`.
...existing questions...

## 16. Regular Expressions
Pattern matching in strings.

**Example:**
```python
import re
pattern = r"\d+"
result = re.findall(pattern, "There are 12 apples and 30 oranges.")
print(result)
```

### Interview Questions
1. **Q:** What does `re.findall()` do?
   **A:** Finds all matches of a pattern in a string.
...existing questions...

## 17. Working with JSON
Parse and generate JSON data.

**Example:**
```python
import json
data = {"name": "Alice", "age": 25}
json_str = json.dumps(data)
print(json_str)
```

### Interview Questions
1. **Q:** How do you parse JSON in Python?
   **A:** Using `json.loads()`.
...existing questions...

## 18. Date and Time
Handle dates and times.

**Example:**
```python
from datetime import datetime
dt = datetime.now()
print(dt)
```

### Interview Questions
1. **Q:** How do you get the current date and time?
   **A:** Using `datetime.now()`.
...existing questions...

## 19. Virtual Environments
Isolate Python projects.

**Example:**
```bash
python -m venv myenv
```

### Interview Questions
1. **Q:** Why use virtual environments?
   **A:** To isolate dependencies for projects.
...existing questions...

## 20. Useful Built-in Functions
Handy functions like `len()`, `type()`, `range()`, `enumerate()`, `zip()`.

**Example:**
```python
lst = [1, 2, 3]
print(len(lst))
print(type(lst))
```

### Interview Questions
1. **Q:** What does `enumerate()` do?
   **A:** Adds a counter to an iterable.
...existing questions...

---

*For each topic above, 20 scenario-based interview questions with answers are provided. Expand each section for more details and practice.*

---

**References:**
- [Python Official Documentation](https://docs.python.org/3/tutorial/index.html)
- [Real Python](https://realpython.com/)
- [GeeksforGeeks Python](https://www.geeksforgeeks.org/python-programming-language/)
- [W3Schools Python](https://www.w3schools.com/python/)
