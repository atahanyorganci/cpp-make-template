#include <iostream>

#include "Hello.h"
#include "Math.h"

int main() {
    hello();
    int a;
    int b;
    std::cout << "Enter two integers.\n";
    std::cin >> a;
    std::cin >> b;
    std::cout << "The result is " << add(a, b) << "." << std::endl;
    return 0;
}
