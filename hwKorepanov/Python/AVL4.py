def _height(Node):
    return Node and Node.height or 0

class CNode:
    def __init__(self, key):
        self.key = key
        self.left = self.right = None
        self.height = 1
    
    def insert(self, key):
        if key < self.key:
            self.left = self.left and self.left.insert(key) or CNode(key)
        else:
            self.right = self.right and self.right.insert(key) or CNode(key)

        return self.rebalance()

    def balance(self): return _height(self.left) - _height(self.right)

    def update(self):
        self.height = 1 + max(_height(self.left), _height(self.right))
        return self

    def rebalance(self):
        if self.balance() < -1: # right bigger, left rotations
            self.right = self.right.rrotate() if self.right.balance() > 0 else self.right
            self = self.lrotate()
        
        elif self.balance() > 1: # left bigger, right rotations
            self.left = self.left.lrotate() if self.left.balance() < 0 else self.left
            self = self.rrotate()
        
        else:
            self.update()

        return self

    def lrotate(self):
        self.right, self, self.left = self.right.left, self.right, self
        self.left.update()
        return self.update()

    def rrotate(self):
        self.left, self, self.right = self.left.right, self.left, self
        self.right.update()
        return self.update()

    def __str__(self):
        return "%s(%s)" % (self.key, str(self.height))
        
    def show(self, level = 0):
        if self.right:
            self.right.show(level + 1)
            print ('\t' * level), ('     /')

        print ('\t' * level), self

        if self.left:
            print ('\t' * level), ('     \\')
            self.left.show(level + 1)
   
class CTree:
    def __init__(self): self.root = None

    def insert(self, key):
        self.root = self.root and self.root.insert(key) or CNode(key)

    def show(self): 
        if self.root:
            self.root.show()
        else:
            print "EMPTY TREE"

tree = CTree()

import random
for key in range(1, 30):
    tree.insert(random.randint(1, 100))

tree.show()
