#include <iostream>
#include "intTree.h"
using namespace std;

intTree::intTree() : root(NULL) {
}

intTreeNode *
intTree::placeNode(class intTreeNode *subTree, class intTreeNode *newNode) {
    if (subTree == NULL)
        return (newNode);
    else {
        if (subTree->getVal() > newNode->getVal())
            subTree->setLeftChildPtr(placeNode(subTree->getLeftChildPtr(), newNode));
        else
            subTree->setRightChildPtr(placeNode(subTree->getRightChildPtr(), newNode));
    }
        return (subTree);
}

intTreeNode *
intTree::removeValue(class intTreeNode *subTree, const int target, bool &success) {
    if (subTree == NULL) {
        success = false;
        return (subTree);
    }
    if (subTree->getVal() == target) {

    // Item is in the root of some subtree
    subTree = removeNode(subTree);
    success = true;
    return (subTree);
    } else {
        if (subTree->getVal() > target) {

        // Search the left subtree
        subTree->setLeftChildPtr(removeValue(subTree->getLeftChildPtr(), target, success));
        } else {

        // Search the right subtree
        subTree->setRightChildPtr(removeValue(subTree->getRightChildPtr(), target, success));
        }
        return subTree;
    }  // end if
}
intTreeNode *
intTree::removeNode(intTreeNode *node){

// Case 1) Node is a leaf - it is deleted
// Case 2) Node has one child - parent adopts child
// Case 3) Node has two children:

//               Traditional implementation: Find successor node.
//               Alternate implementation: Find successor value and replace node's value;
//                  alternate does not need pass-by-reference
    if (node->isLeaf()) {
        delete node;
        return (NULL);
    }
    else if (node->getLeftChildPtr() == NULL) {
        // Has right only
        return node->getRightChildPtr();
    } else if (node->getRightChildPtr() == NULL) { // Has left child only
        return node->getLeftChildPtr();
    } else {// Traditional way to remove a value in a node with two children
        int newNodeValue;
        node->setRightChildPtr(removeLeftMostNode(node->getRightChildPtr(), newNodeValue));
        node->setVal(newNodeValue);
        return (node);
    }
}

intTreeNode *
intTree::removeLeftMostNode(intTreeNode *node, int &inOrderSuccessor) {
    if (node->getLeftChildPtr() == NULL) {
        inOrderSuccessor = node->getVal();
        return (removeNode(node));
    } else {
        node->setLeftChildPtr(removeLeftMostNode(node->getLeftChildPtr(), inOrderSuccessor));
        return (node);
    }
}

// Override findNode because now we can use a binary search:
intTreeNode *
intTree::findNode(intTreeNode *tree, const int target) {
    // Uses a binary search
    if (tree == NULL)
        return tree; // Not found
        else if (tree->getVal() == target)
            return tree; // Found
            else if (tree->getVal() > target)
                // Search left subtree
                return findNode(tree->getLeftChildPtr(), target);
            else
                // Search right subtree
                return findNode(tree->getRightChildPtr(), target);
}  // end findNode
bool
intTree::isEmpty(void) {
    return root == NULL;
}



bool
intTree::add(const int newValue) {
    intTreeNode *newNode = new intTreeNode(newValue);
    root = placeNode(root, newNode);

    return (true);
}

bool
intTree::remove(const int target) {

    bool isSuccessful = false;
    // call may change isSuccessful
    root = removeValue(root, target, isSuccessful);
    return (isSuccessful);
}

void
intTree::preOrderHelper(intTreeNode *tree) {
    if (tree == NULL)
        return;
    cout << tree->getVal() << endl;
    preOrderHelper(tree->getLeftChildPtr());
    preOrderHelper(tree->getRightChildPtr());

}

void
intTree::preOrder() {
    preOrderHelper(root);
}

void
intTree::postOrderHelper(intTreeNode *tree) {
    if (tree == NULL)
        return;
    cout << tree->getVal() << endl;
    postOrderHelper(tree->getLeftChildPtr());
    postOrderHelper(tree->getRightChildPtr());

}

void
intTree::postOrder() {
    postOrderHelper(root);
}


void
intTree::inOrderHelper(intTreeNode *tree) {
    if (tree == NULL)
        return;
    inOrderHelper(tree->getLeftChildPtr());
    cout << tree->getVal() << endl;
    inOrderHelper(tree->getRightChildPtr());

}

void
intTree::inOrder() {
    inOrderHelper(root);
}



void
intTree::inOrder() {
    preOrderTraversalHelper(root);
}