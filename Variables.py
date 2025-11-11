# VAriable = A container for a value (String, integer, float, boolean)
#            A variable behaves as if it was the value it conatins

# Strings, a sequence of characters and numbers
first_name = "Awet"
food = "pizza"
email = "Bro123@ggs.com"

print(f"Hello {first_name}")
# 'f' is used to format the output so you can output your variable with in the string
print(f"I like {food}")
print(f"Your email is: {email}")

# Integers
age = 25
quantity = 3
print(f"You are {age} years old")
print(f"You are buying {quantity} items")

# Floats/Decimals
price = 10.99
gpa = 3.2
print(f"The price is ${price}")
print(f"Your GPA is:{gpa}")

# Boolean
is_student = True
print(f"Are you a student?: {is_student}")

# If statements
if is_student:
    print("You are a student")
else:
    print("You are NOT a studnet")