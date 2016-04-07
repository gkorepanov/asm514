# In my opinion, it's better to have only one field for calculating heights.
# It is the "height" field. It is a property of a node itself, so it's quite logical.

# Thus I have to implement a way to get height.
# I can not get "None.height" 
# So I am to check if the child is None each time I want to get its height.

# It must be either:

# 1) A class like "CEmptyNode with its own "height" field and "balance()" function
# which equal to zero

# 2) Some function that is checking argument for being None
# Where do i put it?! It can't be class method...

# That seems to be a poor solution, but I don't know what else I can do:

class CEmptyNode:
    height = 0
    balance = lambda: 0
    insert = lambda self, key: CNode(key)

    def show(self):
        pass
        
class CNode:
    def __init__(self, key):
        self.key = key
        self.left = CEmptyNode()
        self.right = CEmptyNode()
        self.height = 1
    
    def insert(self, key):
        if key < self.key:
            self.left = self.left.insert(key)
        else:
            self.right = self.right.insert(key)

        return self.rebalance()

    balance = lambda self: self.left.height - self.right.height

    def update(self):
        self.height = 1 + max(self.left.height, self.right.height) 
        return self

    def rebalance(self):
        if self.balance() < -1: # right bigger, left rotationsa
            self = self.lrotate() if self.right.balance() <= 0 else self.lbig_rotate()
        
        elif self.balance() > 1: # left bigger, right rotations
            self = self.rrotate() if self.left.balance() >= 0 else self.rbig_rotate()
        
        else:
            self.update()

        return self


    def lrotate(self):
        self.right, self, self.left = self.right.left, self.right, self
        self.left.update()
        return self

    def rrotate(self):
        self.left, self, self.right = self.left.right, self.left, self
        self.right.update()
        return self.update()

    def lbig_rotate(self):
        self.right = self.right.rrotate()
        self = self.lrotate()
        return self

    def rbig_rotate(self):
        self.left = self.left.lrotate()
        self = self.rrotate()
        return self

    def __str__(self):
        return "%s(%s)" % (self.key, str(self.height))
        
    def show(self, level = 0):
        if self.right.height:
            self.right.show(level + 1)
            print ('\t' * level), ('     /')

        print ('\t' * level), self

        if self.left.height:
            print ('\t' * level), ('     \\')
            self.left.show(level + 1)
   
class CTree:
    def __init__(self):
        self.root = CEmptyNode()
    
    height = lambda self: self.root.height

    def insert(self, key):
        self.root = self.root.insert(key)

    show = lambda self: self.root.show()

tree = CTree()

import random
for key in range(1, 30):
    tree.insert(random.randint(0, 100))

tree.show()
