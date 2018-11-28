ASM = nasm
ASMFLAGS = -f macho64
COLLEEN := Colleen
GRACE := Grace

all: $(COLLEEN) $(GRACE)

$(COLLEEN): Colleen.s
	$(ASM) $(ASMFLAGS) $^ 
	$(CC) -o $@ Colleen.o

$(GRACE): Grace.s
	$(ASM) $(ASMFLAGS) $^ 
	$(CC) -o $@ Grace.o

clean:
	rm -rf *.o Grace_kid.s Sully_*.s

fclean: clean
	rm -rf $(COLLEEN) $(GRACE)

re: fclean all
