import random

class CTree:
    depth = 0

    def __init__(self):
        self.key = None
        self.height = 0
        self.balance = 0

    def insert(self, key):

        if not self.key:
            self.key = key
            self.left = CTree()
            self.right = CTree()
            self.height = self.height + 1

        elif key < self.key:
            self.left.insert(key)
        elif key > self.key:
            self.right.insert(key)

        # if key is the same, no need to add anything

        self.rebalance()

    def rebalance(self):
        self.update()

        if self.balance < -1: # right is bigger, left rotations
            if self.right.balance <= 0:
                self.lrotate()
            else:
                self.lbig_rotate()


        elif self.balance > 1: # right rotations
            if self.left.balance >= 0:
                self.rrotate()
            else:
                self.rbig_rotate()



    # There is really tricky and unbeautiful code, despite the meaning is pretty simple
    # I do not know what to do with it. The problem is self is immutable.
    
    def lrotate(self):
        newleft = CTree()
        newleft.left = self.left
        newleft.right = self.right.left
        newleft.key = self.key
        self.key = self.right.key
        self.right = self.right.right
        self.left = newleft

        newleft.update()
        self.update()
    
    def rrotate(self):
        newright = CTree()
        newright.right = self.right
        newright.left = self.left.right
        newright.key = self.key
        self.key = self.left.key
        self.left = self.left.left
        self.right = newright

        newright.update()
        self.update()

    def lbig_rotate(self):
        self.right.rrotate()
        self.lrotate()

    def rbig_rotate(self):
        self.left.lrotate()
        self.rrotate()

    # get new height and balance
    def update(self):
        self.height = 1 + max(self.left.height, self.right.height)
        self.depth = max(CTree.depth, self.height)
        self.balance = self.left.height - self.right.height

    # print the tree
    def dump(self, level = 0):
        if not self.key:
            return

        if self.right.key:
            self.right.dump(level + 1)
            print ('\t' * level), ('     /')

        print ('\t' * level), self.key
         
        if self.left.key:
            print ('\t' * level), ('     \\')
            self.left.dump(level + 1)


tree = CTree()


for key in range(1, 17):
    tree.insert(random.randint(0, 100))

print\
'---------------------------------------------------------\n\
                      RANDOM TREE:\n\
---------------------------------------------------------'
tree.dump()
