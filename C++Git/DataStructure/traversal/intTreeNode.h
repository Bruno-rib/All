#ifndef INTTREENODE_H_
#define INTTREENODE_H_

class intTreeNode {

private:
    int val;
    intTreeNode *left;
    intTreeNode *right;
public:
    // single constructor
    intTreeNode(const int);

    void setVal(const int);
    int getVal();
    bool isLeaf();

    intTreeNode *getLeftChildPtr();
    intTreeNode *getRightChildPtr();

    void setLeftChildPtr(intTreeNode *);
    void setRightChildPtr(intTreeNode *);
};

#include "intTreeNode.cpp"
#endif /* INTTREENODE_H */