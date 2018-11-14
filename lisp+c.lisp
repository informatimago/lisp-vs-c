// (defun fact (x) (if (zerop x) 1 (* x (fact (1- x)))))
// (format t "~%~D! = ~D~%" 42 (fact 42))
// (quit) #|
#include <stdio.h>

int fact(int x){
  return((0==x)?1:(x*(fact(x-1))));}

int main(){
   printf("\n%d! = %d\n",42,fact(42));
   return(0);}

// |#
