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

x = [1,2,3,4,5,6]
print "=-:-=".join(str(a*a) for a in x if a%2 == 0)


def generate_list_of_squares():
	i = 0
	while 1:
		yield i*i
		i += 1

def take(gen, n):
	for k,i in enumerate(gen):
		if k < n:
			yield i
		else:
			break

print ",".join(str(a) for a in take(generate_list_of_squares(), 10))
print type(generate_list_of_squares())

def account(initial):
	value = [initial]
	def inc(a):
		value[0] += a
		return value[0]
	def dec(a):
		value[0] -= a
		return value[0]

	return (inc, dec)

a1 = account(500)
print a1[0](3)
print a1[1](20)
a1 = 0
print a1


def mygen(m):
	n = [0]
	def next():
		n[0] += m
		return n[0]
	return next


x = mygen(3)
print x()
print x()
print x()
y = mygen(50)
print y()
print y()
print y()

def auth(f):
	def f_auth(self, password, *args):
		if check_password(password):
			return f(self, *args)
		else:
			print "Unauthorized access to %s" % f.__name__
			raise Exception("Unauthorized")
	return f_auth



class Account:
	x = 3
	def __init__(self, initial_value):
		self._value = initial_value

	@auth
	def inc(self, x):
		self._value += x


	@auth
	def dec(self, y):
		self._value -= y

	def get(self):
		return self._value

	get = auth(get)
# a2 = a2 +3 
	def __add__(self, y):
		if type(y) != int:
			print "Type is %s" % type(y)
		else:
			self.inc(y)
		return self

	def __str__(self):
		return "<ACCOUNT %d>" % self._value

def check_password(passwd):
	return True if passwd == '123' else False




a2 = Account(500)
print type(a2)
print "Account.x=", Account.x
print "a2.x =", a2.x
passwd = '123'
wrong_passwd = 'qqq'
print a2.get(passwd)
a2.inc(wrong_passwd, 30)
print a2.get()
a2.dec(40)
print a2.get
print "value=", a2._value

a2 += 3
print a2
a2 = a2 +  3.4
print a2




