import random

class CNode:
    def __init__(self, key):
        self.key = key
        self.left = CTree()
        self.right = CTree()
        self.height = 1
    
    def insert(self, key):
        if key < self.key:
            self.left.insert(key)
        else:
            self.right.insert(key)

    def __str__(self):
        return "%s" % self.key

# wrapper class
class CTree:
    # empty tree creation
    def __init__(self):
        self.node = None
        self.balance = 0
    
    def height(self):
        if not self.node:
            return 0
        else:
            return self.node.height

    def insert(self, key):

        # when 'imaginary' child becomes a real leaf
        if not self.node:
            self.node = CNode(key)

        # else go deeper:
        else:
            self.node.insert(key)

        # avl part
        self.rebalance()

    # get new height and balance
    def update(self):
        self.node.height = 1 + max(self.node.left.height(), self.node.right.height())
        self.balance = self.node.left.height() - self.node.right.height()

    def rebalance(self):

        # get new heights:
        self.update()

        # and balance them properly. conditions are simple enough:
        if self.balance < -1: # right is bigger, left rotations
            if self.node.right.balance <= 0:
                self.lrotate()
            else:
                self.lbig_rotate()


        elif self.balance > 1: # right rotations
            if self.node.left.balance >= 0:
                self.rrotate()
            else:
                self.rbig_rotate()



    
    def lrotate(self):
        # temporary node:
        node = self.node
        
        # move self
        self.node = self.node.right.node
        
        node.right.node = self.node.left.node
        self.node.left.node = node

        self.node.left.update()
        self.update()


    def rrotate(self):
        node = self.node

        self.node = self.node.left.node
        
        node.left.node = self.node.right.node
        self.node.right.node = node

        self.node.right.update()
        self.update()

    def lbig_rotate(self):
        self.node.right.rrotate()
        self.lrotate()

    def rbig_rotate(self):
        self.node.left.lrotate()
        self.rrotate()

      # print the tree
    def dump(self, level = 0):
        if not self.node:
            print 'EMPTY TREE'
            return

        if self.node.right.node:
            self.node.right.dump(level + 1)
            print ('\t' * level), ('     /')

        print ('\t' * level), self.node

        if self.node.left.node:
            print ('\t' * level), ('     \\')
            self.node.left.dump(level + 1)
        
tree = CTree()


for key in range(1, 30):
    tree.insert(random.randint(0, 100))

print\
'---------------------------------------------------------\n\
                      RANDOM TREE:\n\
---------------------------------------------------------'
tree.dump()
