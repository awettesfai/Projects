# input() = A function that prompts the user to enter data
#           Returns the entered data as a string

name = input("What is your name?: ")
print(f"Hello {name}!")

# using a typecasting function with input(), you can change
# the input value to another variable type
age = int(input("How old are you?: "))
print(f"You are {age} years old!")

age += 1

print(f"Hello {name}\nHappy Birthday, you are {age} years old")
