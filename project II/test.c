#include <stdio.h>
#include <assert.h>

// Declare the external assembly function
extern long register_adder(long a, long b);

int main() {
    long result;

    // Test 1
    result = register_adder(2, 3);
    assert(result == 5);
    printf("Test 1 Passed: 2 + 3 = %ld\n", result);

    // Test 2
    result = register_adder(10, -5);
    assert(result == 5);
    printf("Test 2 Passed: 10 + (-5) = %ld\n", result);

    // Test 3
    result = register_adder(0, 0);
    assert(result == 0);
    printf("Test 3 Passed: 0 + 0 = %ld\n", result);

    // Test 4
    result = register_adder(123456, 654321);
    assert(result == 777777);
    printf("Test 4 Passed: 123456 + 654321 = %ld\n", result);

    return 0;
}
