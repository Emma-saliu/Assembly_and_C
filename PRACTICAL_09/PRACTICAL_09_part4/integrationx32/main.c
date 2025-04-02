#include <stdio.h>

extern int add(int a, int b, int c);
extern int sub(int a, int b);

int main(int argc, char **argv)
{
  int sum = add(4, 6, 2);
  int diff = sub(10, 5);
  printf("Sum: %d/n" , sum);
  printf("Difference: %d/n" , diff);
  return 0;
}
