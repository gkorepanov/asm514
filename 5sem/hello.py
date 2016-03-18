import re


adder = lambda a: (lambda x: a+x)

lst = [1,2,3,4,5,6,7,9]
# qlwkejlqwkjelqkwje
print type(lst)

print ", ".join(str(x) for x in lst)

print type(str(x) for x in lst)


result = ""
first = True
for x in lst:
	if not first:
		result += ", "
	else:
		first = False
	result += str(x)

print result

print "Hello world"



a = input("Please enter 'a' ... \n")
b = input("Please enter 'b' ... \n")
print "Result: %10d + %d = %f" % \
	(int(a), int(b), (lambda a: lambda x: a+x)(a)(b))
print a+b
