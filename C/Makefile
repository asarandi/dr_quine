#cat Sully.c | tr '\n' '@' | tr '\t' '~' | tr '"' '?' | sed 's/%/%%/g' | sed 's/[@~?]/%c/g'
#cat Sully.c | tr '\n' '@' | tr '\t' '~' | tr '"' '?' | sed 's/[^5@~?]//g' | sed 's/@/10,/g' | sed 's/~/9,/g' | sed 's/?/34,/g'

CFLAGS = -Wall -Werror -Wextra
COLLEEN := Colleen
GRACE := Grace
SULLY := Sully

all: $(COLLEEN) $(GRACE) $(SULLY)

$(COLLEEN): Colleen.c
	$(CC) $(CFLAGS) -o $@ $^ 

$(GRACE): Grace.c
	$(CC) $(CFLAGS) -o $@ $^ 

$(SULLY): Sully.c
	$(CC) $(CFLAGS) -o $@ $^ 

clean:
	rm -rf *.o a.out* Grace_kid.c Sully_*

fclean: clean
	rm -rf $(COLLEEN) $(GRACE) $(SULLY)

re: fclean all
