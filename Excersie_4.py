# Find the Hypothnus of a right angle triangle
import math

a = float(input("Enter side A: "))
b = float(input("Enter side B: "))

c = math.sqrt(pow(a, 2) + pow(b, 2))
print(f"The Hypothus of the right angle triangle {round(c, 2)}")