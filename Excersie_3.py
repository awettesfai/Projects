# Calculate the circumference of a circle
import math

radius = float(input("What is the radius of the circle: "))
circumference = 2 * math.pi * radius

print(f"The circumference is {round(circumference, 2)}")

# Calculate the area of a circle

area = math.pi * pow(radius, 2)

print(f"The area is {round(area, 2)}")