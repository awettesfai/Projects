# Typecasting = the process of converting a variable from one data type to another
#               str(), int(), float(), bool()

name = "Bro Code"
age = 25
GPA = 3.6
is_studnet = True

# type() is used to show the type of variable
print(type(is_studnet))

flaot_to_int_GPA = int(GPA)
print(flaot_to_int_GPA)

# When typecasting a string to a boolean, the value will return true if
# the string isn't empty, false if it is empty
name = bool(name)

print(name)