#include <iostream>
using namespace std;

int fibonacciIterative(int n);

int main()
{
    int fibonacciResult1 = fibonacciIterative(10);
    cout << "Result: " << fibonacciResult1 << endl;

    return 0;
}

int fibonacciIterative(int n)
{
    twicePrevious = 0;
    previous = 0;
    current = 1;

    cout << "Sequence: "
    for (int i = 1; i < n; i++)
    {
        cout << current << " ";
        twicePrevious = previous;
        previous = current;
        current = previous + twicePrevious;
    }
    cout << endl;
    return current;
}