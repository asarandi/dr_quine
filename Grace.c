#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

/*
** dr_quine [grace], 42 fremont, nov 2018
*/

#define SELF "#include <fcntl.h>%c#include <unistd.h>%c#include <stdio.h>%c%c/*%c** dr_quine [grace], 42 fremont, nov 2018%c*/%c%c#define SELF %c%s%c%c#define DQ 34%c#define EXEC int main(void) { int fd; if ((fd = open(%cGrace_kid.c%c, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0) { (void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,DQ,SELF,DQ,10,10,DQ,DQ,10,10,10); (void)close(fd); } return 0;}%c%cEXEC%c"
#define DQ 34
#define EXEC int main(void) { int fd; if ((fd = open("Grace_kid.c", O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0) { (void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,DQ,SELF,DQ,10,10,DQ,DQ,10,10,10); (void)close(fd); } return 0;}

EXEC
