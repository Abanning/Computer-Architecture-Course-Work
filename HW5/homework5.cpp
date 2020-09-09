// @author: Alex Banning
// @filename: homework5.cpp
// @assignment: HW5 -- Comp Architecture
// @date: 2/28/20
// @description: Compares the fibonacci execution time for iterative
//               vs. recursive implementations and displays the results.

#include <iostream>
#include <ctime>
using namespace std;

// Function Prototypes
int getValue();
long int fibonacciIterative(int n);
long int fibonacciRecursive(int n);

int main()
{
    // Declare variables
    long int fibonacciResult1;
    long int fibonacciResult2;
    clock_t start;
    clock_t stop;
    clock_t duration;
    double durationDisplay[10];
    double durationDisplayStep;
    double durationSum, durationAvg;

    // Get fibonacci input
    int n = getValue();
    cout << endl;
    cout << "Fibonacci(" << n << ")";
    cout << "ITERATIVE" << endl << endl;
    cout << endl;
    // Run 10 times Iterative
    for (int i = 0; i < 10; i++)
    {
        cout << "-------------------------------------------------------------------" << endl;
        cout << "Trial: " << (i + 1) << endl;
        start = clock();
        fibonacciResult1 = fibonacciIterative(n);
        stop = clock();
        duration = stop - start;
        durationDisplayStep = (double)duration/CLOCKS_PER_SEC;
        durationDisplayStep = durationDisplayStep * 1000000;
        durationDisplay[i] = durationDisplayStep;
        cout << "Result: " << fibonacciResult1 << endl;
        cout << "Time duration: " << durationDisplay[i] << " us" << endl;
        cout << endl;
    }
    // Calculate average time
    for (int j = 0; j < 10; j++)
    {
        durationSum += durationDisplay[j];
    }
    durationAvg = durationSum / 10;
    cout << "Average time: " << durationAvg << " us" << endl << endl;
    cout << endl;

    cout << endl;
    cout << "Fibonacci(" << n << ")";
    cout << "RECURSIVE" << endl << endl;
    cout << endl;
    // Run 10 times recursive
    for (int i = 0; i < 10; i++)
    {
        cout << "-------------------------------------------------------------------" << endl;
        cout << "Trial: " << (i + 1) << endl;
        start = clock();
        fibonacciResult2 = fibonacciRecursive(n);
        stop = clock();
        duration = stop - start;
        durationDisplayStep = (double)duration/CLOCKS_PER_SEC;
        durationDisplayStep = durationDisplayStep * 1000000;
        durationDisplay[i] = durationDisplayStep;
        cout << "Result: " << fibonacciResult1 << endl;
        cout << "Time duration: " << durationDisplay[i] << " us" << endl;
        cout << endl;
    }
    // Calculate average time
    for (int j = 0; j < 10; j++)
    {
        durationSum += durationDisplay[j];
    }
    durationAvg = durationSum / 10;
    cout << "Average time: " << durationAvg << " us" << endl << endl;

    return 0;
}

// @description: gets a value for fibonacci(n) from user
// @pre: none
// @post: returns a value to main for fibonacci sequence
// @usage: int n = getValue();
int getValue()
{
    int n;
    cout << endl;
    cout << "WARNING! Entering a value of n larger than 92" << endl;
    cout << "will result in sign overflow and an incorrect Fibonacci" << endl;
    cout << "value. Best results come from 10 < n < 90." << endl << endl;
    cout << "Please enter a value for n: ";
    cin >> n;
    return n;
}

// @description: Runs the fibonacci(n) sequence using an iterative method
// @pre: 10 < n < 90 for best case, but n is an integer
// @post: returns the fibonacci(n) value
// @usage: long int fibonacciNum = fibonacciIterative(40);
long int fibonacciIterative(int n)
{
    long int twicePrevious = 0;
    long int previous = 0;
    long int current = 1;

    // cout << "Sequence: ";
    // cout << previous << " ";
    for (int i = 1; i < n; i++)
    {
        // cout << current << " ";
        twicePrevious = previous;
        previous = current;
        current = previous + twicePrevious;
    }
    // cout << current << endl;
    // cout << endl;
    return current;
}

// @description: Runs the fibonacci(n) sequence using a recursive method
// @pre: 10 < n < 90 for best case, but n is an integer
// @post: returns the fibonacci(n) value
// @usage: long int fibonacciNum2 = fibonacciRecursive(40);
long int fibonacciRecursive(int n)
{
    if (n = 0)
    {
        return 0;
    }
    else if (n = 1)
    {
        return 1;
    }
    else if (n = 2)
    {
        return 1;
    }
    else
    {
        return (fibonacciRecursive(n -1) + fibonacciRecursive(n - 2));
    }
}
