#include <iostream>

int square(int x) {
    return x * x;
}

int main() {
    int a = 5;
    int b = square(a);
    std::cout << "The square of " << a << " is " << b << std::endl;
    return 0;
}
