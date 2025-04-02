EXECUTABLE=IntegratingCandASM

all: $(EXECUTABLE)

$(EXECUTABLE): main.o add.o sub.o gcc -m32 main.o add.o sub.o -o $(EXECUTABLE)

main.o: main.c
	gcc -m32 -c main.c

add.o: add.asm 
	nasm -f elf32 add.asm -o add add.o -l add.lst

sub.o: sub.asm
	nasm -f elf32 sub.asm -o sub.o -l sub.lst

#Clean folder
clean:
	rm -rf *o *.lst $(EXECUTABLE)