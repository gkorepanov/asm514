def _h(node):
    return node[2] if node else  0

def balance(node):
    if node:
        (l, key, height, r) = node
        return _h(l) - _h(r)

    return 0

def new_height(l, r):
    return 1 + max(_h(l), _h(r))

def lrotate(node):
    l, key, h, r = node
    rl, rkey, rh, rr = r

    l = (l, key, new_height(l, rl), rl)
    return (l, rkey, new_height(l, rr), rr)


def rrotate(node):
    l, key, h, r = node
    ll, lkey, lh, lr = l

    r = (lr, key, new_height(lr, r), r)
    return (ll, lkey, new_height(ll, r), r)

def rebalance(node):
    (l, key, height, r) = node
    bal = balance(node)

    if bal == 2:
        if balance(l) < 0:
            l = lrotate(l)
        node = rrotate((l, key, new_height(l,r),r))

    elif bal == -2:
        if balance(r) > 0:
            r = rrotate(r)
        node = lrotate((l, key, new_height(l,r), r))

    return node
        
def tree_insert(node, x):
    if node is None:
        return (None, x, 1, None)

    (l, key, height, r) = node

    if x > key:
        r = tree_insert(r, x)
    elif x < key:
        l = tree_insert(l, x)
    else:
        return node

    return rebalance((l, key, new_height(l, r), r))

def show(node, level = 0):
    (l, key, height, r) = node

    if r:
        show(r, level + 1)
        print ('\t' * level), ('     /')

    print ('\t' * level), str(key)

    if l:
        print ('\t' * level), ('     \\')
        show(l, level + 1)
 
import random
tree = None
num = input()
for key in xrange(num):
    tree = tree_insert(tree, random.randint(0, 100000))

show(tree)
