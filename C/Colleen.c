#include <stdio.h>

/*
** comment outside main function
*/

#define SELF "#include <stdio.h>%c%c/*%c** comment outside main function%c*/%c%c#define SELF %c%s%c%c%cvoid colleen()%c{%c%cprintf(SELF,10,10,10,10,10,10,34,SELF,34,10,10,10,10,9,10,10,10,10,10,10,10,10,10,9,10,9,10,10);%c}%c%cint main()%c{%c%c/*%c** comment inside main%c*/%c%ccolleen();%c%creturn (0);%c}%c"

void colleen()
{
	printf(SELF,10,10,10,10,10,10,34,SELF,34,10,10,10,10,9,10,10,10,10,10,10,10,10,10,9,10,9,10,10);
}

int main()
{

/*
** comment inside main
*/
	colleen();
	return (0);
}
