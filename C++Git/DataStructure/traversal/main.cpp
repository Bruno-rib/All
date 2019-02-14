#include <iostream>
#include "intTree.h"
using namespace std;

int main() {
    intTree *iTree = new intTree();

    iTree->add(60);
    iTree->add(20);
    iTree->add(70);
    iTree->add(10);
    iTree->add(40);
    iTree->add(30);
    iTree->add(50);



    cout << "Pre-order traverse: " << endl;
    iTree->preOrder();
    cout << endl;

    cout << "-order traverse: " << endl;
    iTree->postOrder();
    cout << endl;

    cout << "-order traverse: " << endl;
    iTree->inOrder();
    cout << endl;


}