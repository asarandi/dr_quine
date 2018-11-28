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
	rm -rf *.o Grace_kid.c Sully_*

fclean: clean
	rm -rf $(COLLEEN) $(GRACE) $(SULLY)

re: fclean all
