"""
This is a dumb calculator that can add and subtract whole numbers from zero to five.
When you run the code, you are prompted to enter two numbers (in the form of English
word instead of number) and the operator sign (also in the form of English word).
The code will perform the calculation and give the result if your input is what it
expects.

The code is very long and messy. Refactor it according to what you have learned about
code simplicity and efficiency.
"""

print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')


 
NUMEROS = {'zero': 0,'one':1,'two':2,'three':3,'four':4,'five':5,'six':6,'seven':7,'eight':8,'nine':9,'ten':10,'minus one':-1,'minus two':-2,'minus three':-3,'minus four':-4, 'minus five':-5}



def calculator (a,b,c):
    
    x = NUMEROS[a]
    y = NUMEROS[c]
    if x > 5 or y > 5 or x < 0 or y < 0:
      return "I am not able to answer this question. Check your input."
    elif b == 'minus':
      z = x - y
      return "{} {} {} equals {}".format (a,b,c,buscaclave(z))
    elif b == 'plus':
      z = x + y
      return "{} {} {} equals {}".format (a,b,c,buscaclave(z))
    

def buscaclave (valor):
  for k, v in NUMEROS.items():
    if v == valor:
      return(k)

print (calculator(a,b,c))

print("Thanks for using this calculator, goodbye :)")
