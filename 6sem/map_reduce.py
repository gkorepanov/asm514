"""
for i in xrange(123123):
	...
	..
	..
	.

while True:
	...
	..
	...
	..
"""

l = [1,3,4,5,6+3j,7,8,9]

print map(lambda x: x-1,l)



print filter(lambda x: abs(x) > 5, l)


print reduce(lambda x, y: x*y, l, 1)


import itertools


def generator(n):
	for i in xrange(n):
		yield i

print itertools.imap(lambda x: x*x, generator(30))


