# Bruno S Ribeiro - PC7439


#1.	interpretation
# The fact that interpretation is slower than compilation (c++) it is
#   not noticeable. but I do enjoy having the option of changing one
#   line of and seeing a change in my final program without having to
#   compile the whole program again.
#   Interpretation in some way allows easy writability, much less commands
#   to achieve an goal and as a read through the internet often the programmer
#   time is the most expensive when creating an app. Personally it makes me
#   happy coding in python since I can fix run time errors much easier than I can
#   understand and fix c++ compilation errors.
#   therefore, if I don't state on the following items just assume that the python
#   functionality, in my opinion, is better than compilation languages such as c++

#4.	numeric types
# clean syntax and no need to differentiate your number into integer, float,
# double, etc. Even though that the interpreter is considering all digits as
# float points and automatic allocating "enough" memory, I still have the
# option to declare less memory. I do have the remainder and integer
# division option, so there is no lack of functionality when compared to
# C++ but an improvement in readability and writeability

a = 3 * 4
b = 12 / 4
c = 12 // 4
d = 3 ** 4
e = 8 + 2 * 10
f = 18 % 4

#16.	indentation to denote code blocks
# a cleaner way to acquire the goal of scoping. C++ has the brackets but is common practice to indent
# your code anyways which make the brackets pointless. Languages like Pascal have the for "begin" and "end"
# keywords which, if necessary for python can be accomplished with comments


#11.	dictionaries
# a mix of multidimensional array and switch statement with the choice of using multiple data types.
# Incredible flexible with the type and amount of data that can be saved in it. To have a dictionary
# data type in c++ we would have to make linked lists set in a struct that link to each element of other
# linked list (to support different data types) and a function to hash the keys. That program would take
# over a day to code for a beginner like me


#13.	switch statement
# python does not have this functionality since dictionaries can do
# all that a switch statement can do and much more

def numbers_to_strings(argument):
    switcher = {
        0: "zero",
        1: "one",
        2: "two",
    }
    return switcher.get(argument, "nothing")


#6.	arrays (refers to next line of code)
# It is not supported because lists have all its features
#   in c++ you always have to define size for arrays
#   and when you create tools to analyze internet data
#   or even a simple program for school I always used more
#   memory than I needed to save my time because computers
#   in 2019 are rarely affected by a program that does
#   not save memory.

#5.	strings (refers to next line of code)
# The fact that I don't have to import a library to use strings and
# functionalities such as calculating the length makes me a happy coder.
# The ability to use single quotes or double quotes saves me time instead
# of trying to figure how many backlashes I have to insert if I am trying
# to print to screen "\t" (3 in c++ vs. one in python)

#7.	lists
# After programming in c++ you see a list and
# you can't accept how one day when you used to code in c++
# you had to count elements before make a list, you had to use
# different arrays for different data types and then link the arrays,
# and if you want to use something that supports different data types
# you had to create a struct or a class

groceries = ['bacon','"\\t"', 'ham', 9, True, a, b, c, d, e, f]

#20 print (refers to the next for loop)
# no percentage signs needed or concatenation sign (even though you can
# use concatenation) for strings the comma is "overloaded."
# if compared with cout there is no need for ofstream operators,
# also just a comma here, which makes simpler
# and easier to understand (again: readability++, and writability++)

#14.	for loop
# For loops have a much cleaner and faster way to be written.
# Great thinking about facilitating the syntax of going through a list, since
# 95% of times I used a for loop in c++ was to go through an array or a string,
# and initializing a counter and performing i++ should be a given.

for g in groceries[0:2]:
    print (groceries.index(g)+1,")",'.', g)
    print(len(g))

for g in groceries[2:]:
    print (g)

#10.	index range checking
# an easy to use and comprehensive syntax for beginner programmers to understand. It has the same
# functionalities that c++ has with less complicated syntax and no need to declare a variable for it

for x in range(5 ,12, 2):
    print(x)

#19.	functions
# The option of being able to pass an unlimited amount of
# arguments make functions a need to run online data through it. Combined
# with the for loop is a simple tool with a vast range of use

def addNumbers(*args):
    total = 0
    for a in args:
        total += a
    print("The total is ",total)

addNumbers(3)
addNumbers(3, 54, 9874, 54, 0, 5, 87, 5.5)

#8.	tuples The addition of a list that cannot be modified makes it much
# more straightforward than having to define tons of constants at the
# beginning of your c++ program


numbers = (1, 2, 3, 4, 5)
string = "crazy string"
#9.	slice
# it separates elements in many different ways and orders. The only way
# that I can think I could get the same functionality would be using and array
# and selecting the elements with the bracket notation and a for loop

sliceNumbers = slice(2, 4, 1)
print("numbers sliced: ", numbers[sliceNumbers])
print("string sliced: ", string[sliceNumbers])

#15.	while loop
# while loop has all the functionalities that exist in other languages
# but the syntax is improved

#12.	if statement
# much easier to understand a program using is instead of ==
# and great idea to have a simplified version since most of time using if/else
# statement you are using to equal something. Also has all other functionalities

#2.	Boolean expressions
# Python makes easier to assign boolean expressions to variables and to
# reassign a previous used variable to a different data type such as boolean
# also the use of "and" "or" and "not" makes less need to memorize
# signs for those functionalities

#3.	short circuit evaluation
# it has the same procedure C++ has in which only check the second argument if has too

y = 5;
d = a >= b

while y < 10:
    if y is 7:
        print (y)
    elif a >= b and a > c:
        print (d)
    y += 1


#17.	type binding
# anonymus online comment: "the most Pythonic way
# to check the type of an object is... not to check it"
# binding makes coding harder therefore the lack of it is a helpful feature
# for print purposes a coder can make a variable behave as a c++ data type
# by using a function but there is also ways to go around that if you stop
# thinking so much C++ - like

#18.	type checking
# type check in python occurs dynamically only when code runs which allows great
# flexibility. Variables can change type along the code runs
# c++ makes you assign a data type which makes harder to achieve a goal
# when writing a program and if for example you added doubles and try to
# get a remainder of a division it will be an entire extra function and some
# casting required which python can do in one line

import math

a = True
a = 7.2
b = int(a)
c = math.floor(a)
print(a, b, c)


# Python Language
# In 2019 programmer time is the most expensive part of creating an app
# therefore the use of python for creating smaller apps
# (which my guess makes 95% of the internet and 50 % of desktops programs)
# makes Python a must use. It also makes me happy that I can be more creative
# when coding instead of having to deal with small details of a language such as:
# - out range arrays
# - Or creating a struct or a class to hold data.

# python is so intuitive and flexible that I guessed I could use floor function
# when it didn't work I tried "import math" and to my surprise it worked
# my point is that is so easy that you can almost use english like language
# to make your code work

# note that: Most of the lines of code from the above program were acquired while
# I was going through a tutorial on youtube at the newBoston channel






