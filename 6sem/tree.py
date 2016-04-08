def h(t):
	t and t[2] or 0

def balance(t):
	if t:
		l, c, h, r = t
		return h(l) - h(r)
	return 0

def height(l, r):
	return 1+max(h(l), h(r))

def lrotate(t):
	l, c, h, r = t
	rl, rc, rh, rr = r
	l = (l, c, height(l, rl), rl)
	return (l, c, height(rr, l), rr)

def rrotate(t):
	l, c, h, r  = t
	ll, lc, lh, lr = l
	r = (lr, c, height(r, lr), r) 
	return (ll, c, height(ll, r), r)


def check_and_rotate(l, c, h, r):
	t = (l, c, h, r)
	bal = balance(t)
	if bal == 2:
		if balance(l) < 0:
			l = lrotate(l)
		t = rrotate((l, c, height(l,r),r))
	elif bal == -2:
		if balance(r) > 0:
			r = rrotate(r)
		t = lrotate((l, c, height(l,r), r))

	return t
		
def tree_insert(t, x):
	if t is None:
		return (None, x, 1, None)
	l, c, h, r = t
	if x > c:
		r = tree_insert(r, x)
	else:
		l = tree_insert(l, x)
	return check_and_rotate(l, c, height(l, r), r)


import random
t = None
for i in xrange(1000000):
	t = tree_insert(t, random.randint(-10000, 10000))

print



#def inv(t, dr=False):
#	if dr:
#		return (t[3], t[1], t[2], t[0])
#	return t

#def rotate(t, dr=False):
#	l, c, h, r = inv(t, dr)
#	rl, rc, rh, rr = r
#	l = inv((l, c, height(l, rl), rl), dr)
#	return (l ,rc, height(rr, l), rr)


#def inv(t, dr=False):
#	if dr:
#		return (t[3], t[1], t[2], t[0])
#	return t

#def rotate(t, dr=False):
#	l, c, h, r = inv(t, dr)
#	rl, rc, rh, rr = r
#	l = inv((l, c, height(l, rl), rl), dr)
#	return (l ,rc, height(rr, l), rr)


#def inv(t, dr=False):
#	if dr:
#		return (t[3], t[1], t[2], t[0])
#	return t

#def rotate(t, dr=False):
#	l, c, h, r = inv(t, dr)
#	rl, rc, rh, rr = r
#	l = inv((l, c, height(l, rl), rl), dr)
#	return (l ,rc, height(rr, l), rr)



