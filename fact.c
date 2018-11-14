#include <stdio.h>

int fact(int x)
{
    if(0==x)
    {
        return(1);
    }
    else
    {
        return(x*fact(x-1));
    }
}

int main()
{
   printf("\n%d! = %d\n",42,fact(42));
   return(0);
}
