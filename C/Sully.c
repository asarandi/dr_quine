#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#define SELF    "#include <string.h>%c#include <fcntl.h>%c#include <unistd.h>%c#include <stdio.h>%c#include <stdlib.h>%c%c#define SELF    %c%s%c%c#define EXECCMD %c/usr/bin/cc -Wall -Werror -Wextra -I /usr/include -o Sully_%%d Sully_%%d.c && ./Sully_%%d%c%c#define SRCFILE %cSully_%%d.c%c%c%cint main()%c{%c    int     i = %d;%c    int     fd;%c    char    *src_file;%c    char    *exec_cmd;%c%c    if (i > 0)%c    {%c        if ((strchr(__FILE__, '_')) != NULL)%c            i--;%c        src_file = NULL;%c        (void)asprintf(&src_file, SRCFILE, i);%c        if ((fd = open(src_file, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0)%c        {%c            (void)dprintf(fd,SELF,10,10,10,10,10,10,34,SELF,34,10,34,34,10,34,34,10,10,10,10,i,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);%c            (void)close(fd);%c            exec_cmd = NULL;%c            (void)asprintf(&exec_cmd, EXECCMD, i, i, i);%c            (void)system(exec_cmd);%c            (void)free(exec_cmd);%c        }%c        (void)free(src_file);%c    }%c    return (0);%c}%c"
#define EXECCMD "/usr/bin/cc -Wall -Werror -Wextra -I /usr/include -o Sully_%d Sully_%d.c && ./Sully_%d"
#define SRCFILE "Sully_%d.c"

int main()
{
    int     i = 5;
    int     fd;
    char    *src_file;
    char    *exec_cmd;

    if (i > 0)
    {
        if ((strchr(__FILE__, '_')) != NULL)
            i--;
        src_file = NULL;
        (void)asprintf(&src_file, SRCFILE, i);
        if ((fd = open(src_file, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0)
        {
            (void)dprintf(fd,SELF,10,10,10,10,10,10,34,SELF,34,10,34,34,10,34,34,10,10,10,10,i,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
            (void)close(fd);
            exec_cmd = NULL;
            (void)asprintf(&exec_cmd, EXECCMD, i, i, i);
            (void)system(exec_cmd);
            (void)free(exec_cmd);
        }
        (void)free(src_file);
    }
    return (0);
}
