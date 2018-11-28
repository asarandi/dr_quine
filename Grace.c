#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

/*
** dr_quine [grace], 42 fremont, nov 2018
*/

#define EXEC int main(void) { (void)write_kid(); return 0;};
#define DQ 34
#define SELF "#include <fcntl.h>%c#include <unistd.h>%c#include <stdio.h>%c%c/*%c** dr_quine [grace], 42 fremont, nov 2018%c*/%c%c#define EXEC int main(void) { (void)write_kid(); return 0;};%c#define DQ 34%c#define SELF %c%s%c%c%cvoid%cwrite_kid(void)%c{%c%cint fd;%c%c%cif ((fd = open(%cGrace_kid.c%c, O_WRONLY | O_CREAT | O_TRUNC, 0666)) > 0)%c%c{%c%c%c(void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,10,10,34,SELF,34,10,10,9,10,10,9,10,10,9,34,34,10,9,10,9,9,10,9,9,10,9,10,10,10,10,10);%c%c%c(void)close(fd);%c%c}%c}%c%c%cEXEC%c"

void	write_kid(void)
{
	int fd;

	if ((fd = open("Grace_kid.c", O_WRONLY | O_CREAT | O_TRUNC, 0666)) > 0)
	{
		(void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,10,10,34,SELF,34,10,10,9,10,10,9,10,10,9,34,34,10,9,10,9,9,10,9,9,10,9,10,10,10,10,10);
		(void)close(fd);
	}
}


EXEC
