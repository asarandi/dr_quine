#include <stdio.h>

/* comment outside main function */

#define nl 10
#define q 34

void print_self()
{
	char *self = "#include <stdio.h>%c%c/* comment outside main function */%c%c#define nl 10%c#define q 34%c%cvoid print_self()%c{%c	char *self = %c%s%c;%c	printf(self,nl,nl,nl,nl,nl,nl,nl,nl,nl,q,self,q,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl);%c}%c%cint main()%c{%c%c/*%c** comment inside main%c*/%c	print_self();%c	return (0);%c}%c";
	printf(self,nl,nl,nl,nl,nl,nl,nl,nl,nl,q,self,q,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl);
}

int main()
{

/*
** comment inside main
*/
	print_self();
	return (0);
}
