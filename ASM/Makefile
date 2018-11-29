#cat Sully.s | sed 's/^/db\ "/g' | sed 's/$/",10/g' >> Sully.s 

ASM = nasm
ASMFLAGS = -g -f macho64
COLLEEN := Colleen
GRACE := Grace
SULLY := Sully

all: $(COLLEEN) $(GRACE) $(SULLY)

$(COLLEEN): Colleen.s
	$(ASM) $(ASMFLAGS) $^ 
	$(CC) -o $@ Colleen.o

$(GRACE): Grace.s
	$(ASM) $(ASMFLAGS) $^ 
	$(CC) -o $@ Grace.o

$(SULLY): Sully.s
	$(ASM) $(ASMFLAGS) $^ 
	$(CC) -g -o $@ Sully.o



clean:
	rm -rf *.o Grace_kid.s Sully_* Sully.o

fclean: clean
	rm -rf $(COLLEEN) $(GRACE) $(SULLY)

re: fclean all
