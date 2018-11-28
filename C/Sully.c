#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#define SELF    "#include <string.h>%c#include <fcntl.h>%c#include <unistd.h>%c#include <stdio.h>%c#include <stdlib.h>%c%c#define SELF    %c%s%c%c#define CC      %c/usr/bin/cc%c%c#define CFLAG1  %c-Wall%c%c#define CFLAG2  %c-Werror%c%c#define CFLAG3  %c-Wextra%c%c#define INC     %c-I /usr/include%c%c#define SRCNAME %cSully_%%d.c%c%c#define BINNAME %cSully_%%d%c%c#define CC_O    %c-o%c%c%cint main()%c{%c    int     i = %d;%c    int     fd;%c    pid_t   pid_cc;%c    pid_t   pid_child;%c%c    if ((strchr(__FILE__, '_')) != NULL)%c        i--;%c%c    char *src_name = NULL;%c    (void)asprintf(&src_name, SRCNAME, i);%c%c    char *bin_name = NULL;%c    (void)asprintf(&bin_name, BINNAME, i);%c%c    if ((fd = open(src_name, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0)%c    {%c        (void)dprintf(fd,SELF,10,10,10,10,10,10,34,SELF,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,10,10,10,i,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);%c        (void)close(fd);%c%c        if ((pid_cc = fork()) == -1)%c            return (0);%c        else if (pid_cc == 0)%c        {%c            execl(CC, CC, CFLAG1, CFLAG2, CFLAG3, INC, CC_O, bin_name, src_name, NULL);%c            exit(0);%c        }%c        else%c            wait4(pid_cc, NULL, 0, NULL);%c%c        if (i > 0)%c        {%c            if ((pid_child = fork()) == -1)%c                return (0);%c            else if (pid_child == 0)%c            {%c                execl(bin_name, bin_name, NULL);%c                exit(0);%c            }%c            else%c                wait4(pid_child, NULL, 0, NULL);%c        }%c    }%c%c    (void)free(src_name);%c    (void)free(bin_name);%c%c    return (0);%c}%c"
#define CC      "/usr/bin/cc"
#define CFLAG1  "-Wall"
#define CFLAG2  "-Werror"
#define CFLAG3  "-Wextra"
#define INC     "-I /usr/include"
#define SRCNAME "Sully_%d.c"
#define BINNAME "Sully_%d"
#define CC_O    "-o"

int main()
{
    int     i = 5;
    int     fd;
    pid_t   pid_cc;
    pid_t   pid_child;

    if ((strchr(__FILE__, '_')) != NULL)
        i--;

    char *src_name = NULL;
    (void)asprintf(&src_name, SRCNAME, i);

    char *bin_name = NULL;
    (void)asprintf(&bin_name, BINNAME, i);

    if ((fd = open(src_name, O_WRONLY | O_CREAT | O_TRUNC, 0644)) > 0)
    {
        (void)dprintf(fd,SELF,10,10,10,10,10,10,34,SELF,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,34,34,10,10,10,10,i,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
        (void)close(fd);

        if ((pid_cc = fork()) == -1)
            return (0);
        else if (pid_cc == 0)
        {
            execl(CC, CC, CFLAG1, CFLAG2, CFLAG3, INC, CC_O, bin_name, src_name, NULL);
            exit(0);
        }
        else
            wait4(pid_cc, NULL, 0, NULL);

        if (i > 0)
        {
            if ((pid_child = fork()) == -1)
                return (0);
            else if (pid_child == 0)
            {
                execl(bin_name, bin_name, NULL);
                exit(0);
            }
            else
                wait4(pid_child, NULL, 0, NULL);
        }
    }

    (void)free(src_name);
    (void)free(bin_name);

    return (0);
}
