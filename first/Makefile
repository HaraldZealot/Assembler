ASSEMBLER=yasm
LINKER=ld

SRC= hello.asm
OBJ= hello.o
BIN= hello

OBJ_FORMAT= elf64
ENTRY_POINT= _start
ASM_F_FLAG=-f
ASM_O_FLAG=-o
LNK_O_FLAG=-o
LNK_E_FLAG=-e

all: $(BIN)

run: $(BIN)
	./$(BIN)

$(BIN): $(OBJ)
	$(LINKER) $(LNK_O_FLAG)$(BIN) $(LNK_E_FLAG)$(ENTRY_POINT) $(OBJ)

$(OBJ): $(SRC)
	$(ASSEMBLER) $(ASM_O_FLAG)$(OBJ) $(ASM_F_FLAG)$(OBJ_FORMAT) $(SRC)

clear:
	rm -f $(OBJ) $(BIN)
