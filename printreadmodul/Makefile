ASSEMBLER=yasm
LINKER=ld

SRC1= main.asm
SRC2= inout.asm
OBJ1= main.o
OBJ2= inout.o
BIN= application

OBJ_FORMAT= elf64
ENTRY_POINT= _start
ASM_F_FLAG=-f
ASM_O_FLAG=-o
LNK_O_FLAG=-o
LNK_E_FLAG=-e

all: $(BIN)

run: $(BIN)
	./$(BIN)

$(BIN): $(OBJ1) $(OBJ2)
	$(LINKER) $(LNK_O_FLAG)$(BIN) $(LNK_E_FLAG)$(ENTRY_POINT) $(OBJ1) $(OBJ2)

$(OBJ1): $(SRC1)
	$(ASSEMBLER) $(ASM_O_FLAG)$(OBJ1) $(ASM_F_FLAG)$(OBJ_FORMAT) $(SRC1)

$(OBJ2): $(SRC2)
	$(ASSEMBLER) $(ASM_O_FLAG)$(OBJ2) $(ASM_F_FLAG)$(OBJ_FORMAT) $(SRC2)

clear:
	rm -f $(OBJ1) $(BIN1) $(OBJ2) $(BIN2)
