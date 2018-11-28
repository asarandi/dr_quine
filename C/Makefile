CFLAGS = -Wall -Werror -Wextra
COLLEEN := Colleen
GRACE := Grace

all: $(COLLEEN) $(GRACE)

$(COLLEEN): Colleen.c
	$(CC) $(CFLAGS) -o $@ $^ 

$(GRACE): Grace.c
	$(CC) $(CFLAGS) -o $@ $^ 

clean:
	rm -rf *.o Grace_kid.c Sully_*.c

fclean: clean
	rm -rf $(COLLEEN) $(GRACE)

re: fclean all
