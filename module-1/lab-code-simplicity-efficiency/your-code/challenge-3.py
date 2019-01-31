"""
You are presented with an integer number larger than 5. Your goal is to identify the longest side
possible in a right triangle whose sides are not longer than the number you are given.

For example, if you are given the number 15, there are 3 possibilities to compose right triangles:

1. [3, 4, 5]
2. [6, 8, 10]
3. [5, 12, 13]

The following function shows one way to solve the problem but the code is not ideal or efficient.
Refactor the code based on what you have learned about code simplicity and efficiency.
"""

def my_function(maximo):
  a = []
  for x in range(5, maximo-1):
    for y in range(4, maximo-1):
      for z in range(3, maximo-1):
        if (x*x==y*y+z*z):
          a.append([x,y,z])
  return max(a)

maximo = int(input("What is the maximal length of the triangle side? Enter a number: "))

print("The longest side possible is " + str(max(my_function(maximo))))