#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

/*
** dr_quine [grace], 42 fremont, nov 2018
*/

#define GRACE_KID "Grace_kid.c"
#define SELF "#include <fcntl.h>%c#include <unistd.h>%c#include <stdio.h>%c%c/*%c** dr_quine [grace], 42 fremont, nov 2018%c*/%c%c#define GRACE_KID %c%s%c%c#define SELF %c%s%c%c#define FT(x)int main() { int fd; if ((fd = open(x, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0) { (void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,34,GRACE_KID,34,10,34,SELF,34,10,10,10,10); (void)close(fd); } return 0; }%c%cFT(GRACE_KID)%c"
#define FT(x)int main() { int fd; if ((fd = open(x, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0) { (void)dprintf(fd,SELF,10,10,10,10,10,10,10,10,34,GRACE_KID,34,10,34,SELF,34,10,10,10,10); (void)close(fd); } return 0; }

FT(GRACE_KID)
