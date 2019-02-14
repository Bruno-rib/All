#ifndef INTTREE_H_
#define INTTREE_H_

#include "intTreeNode.h"

class intTree {
private:
    intTreeNode *root;

    intTreeNode *placeNode(intTreeNode *subTree, intTreeNode *newNode);

    intTreeNode *removeValue(intTreeNode *subTree, int target, bool &success);

    intTreeNode *removeNode(intTreeNode *node);

    intTreeNode *removeLeftMostNode(intTreeNode *node, int &inOrderSuccessor);

    intTreeNode *findNode(intTreeNode *tree, const int target);

public:
    intTree();

    bool isEmpty();

    bool add(const int newValue);

    bool remove(const int removeValue);

    void preOrder();
    void postOrder();
    void inOrder();

    //void preOrderHelper();
};

#include "intTree.cpp"
#endif