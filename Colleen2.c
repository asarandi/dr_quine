#include <stdio.h>

/*
** comment outside main function
*/

#define DQ 34
#define NL 10
#define TB 9
#define SELF "#include <stdio.h>%c%c/*%c** comment outside main function%c*/%c%c#define DQ 34%c#define NL 10%c#define TB 9%c#define SELF %c%s%c%c%cvoid print_self()%c{%c%cprintf(SELF,NL,NL,NL,NL,NL,NL,NL,NL,NL,DQ,SELF,DQ,NL,NL,NL,NL,TB,NL,NL,NL,NL,NL,NL,NL,NL,NL,TB,NL,TB,NL,NL);%c}%c%cint main()%c{%c%c/*%c** comment inside main%c*/%c%cprint_self();%c%creturn (0);%c}%c"

void print_self()
{
	printf(SELF,NL,NL,NL,NL,NL,NL,NL,NL,NL,DQ,SELF,DQ,NL,NL,NL,NL,TB,NL,NL,NL,NL,NL,NL,NL,NL,NL,TB,NL,TB,NL,NL);
}

int main()
{

/*
** comment inside main
*/
	print_self();
	return (0);
}
