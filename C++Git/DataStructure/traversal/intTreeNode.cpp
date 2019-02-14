#include "intTreeNode.h"
#include <cstddef>

intTreeNode::intTreeNode(const int nodeVal) : val(nodeVal), left(NULL),
right(NULL) {

}

void
intTreeNode::setVal(const int newVal) {
    val = newVal;
}

int
intTreeNode::getVal(void) {
    return (val);
}

bool
intTreeNode::isLeaf(void) {
    return ((left == NULL) && (right == NULL));
}

intTreeNode *
intTreeNode::getLeftChildPtr(void) {
    return (left);
}

intTreeNode *
intTreeNode::getRightChildPtr(void) {
    return (right);
}

void
intTreeNode::setLeftChildPtr(intTreeNode *newLeft) {
    left = newLeft;
}

void
intTreeNode::setRightChildPtr(intTreeNode *newRight) {
    right = newRight;
}