import random

def _h(x):
    return x and x.height or 0

class CNode:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        self.height = 1
    
    def insert(self, key):

        # TODO: I dislike the way that if statement written in. Two lines are too similar. In C i would assign
        # a pointer with either left or right child and then will work with that pointer

        if key < self.key:
            self.left = self.left.insert(key) if self.left else CNode(key)
            self.lheight = self.left.height
        else:
            self.right = self.right.insert(key) if self.right else CNode(key)
            self.rheight = self.right.height

        self.balance = self.lheight - self.rheight

        return self.rebalance()
    def bal(self):
        return _h(self.left) - _h(self.right)

    def rebalance(self):
        if self.balance < -1: # right bigger, left rotations
            if self.right.balance <= 0:
                self = self.lrotate()
            else:
                self = self.lbig_rotate()
        

        elif self.balance > 1: # left bigger, right rotations
            if self.left.balance >= 0:
                self = self.rrotate()
            else:
                self = self.rbig_rotate()
        
        else:
            self.update()
    
        return self

    def update(self):
        self.height = 1 + max(self.lheight, self.rheight)
        self.balance = self.lheight - self.rheight

    def lrotate(self):
        node = self.right
        self.right, self.rheight = node.left, node.lheight
        self.update()
        node.left, node.lheight = self, self.height
        node.update()
        return node


    def rrotate(self):
        node = self.left
        self.left, self.lheight = node.right, node.rheight
        self.update()
        node.right, node.rheight = self, self.height
        node.update()
        return node


 
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
        if self.right:
            self.right.show(level + 1)
            print ('\t' * level), ('     /')

        print ('\t' * level), self

        if self.left:
            print ('\t' * level), ('     \\')
            self.left.show(level + 1)
   
class CTree:
    def __init__(self):
        self.root = None
    
    def height(self):
        return self.root.height if self.root else 0

    def insert(self, key):
        if not self.root:
            self.root = CNode(key)
        else:
            self.root = self.root.insert(key)


    def show(self):
        if not self.root:
            print 'EMPTY TREE'
        else:
            self.root.show()
       
tree = CTree()

for key in range(1, 30):
    tree.insert(random.randint(0, 100))

tree.show()
