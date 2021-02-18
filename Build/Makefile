include Make_functions.mk
include Make_variables.mk
.PHONY: all clean make_dir linking start_up_obj

all: linking
	@echo "complete building...";\
	$(GET_SIZE) $(BIN_FOLDER)/$(OUTPUT)

linking: $(DEP_LST) $(OBJ_LST) start_up_obj
	echo "=================================";\
	echo "linking....";\
	echo "making bin to $(BIN_FOLDER)";\
	$(LKER) $(LDFLAGS) -o $(BIN_FOLDER)/$(OUTPUT) $(OBJ_LST) $(OBJ_FOLDER)/startup_stm32f407vgtx.o -T"./Lkr_script/STM32F407VGTX_FLASH.ld"

make_dir:
	@mkdir -p $(DEP_FOLDER) $(OBJ_FOLDER) $(BIN_FOLDER);

clean:
	@echo "cleaning deps...";\
	rm -f $(DEP_FOLDER)/*;\
	echo "cleaning objs...";\
	rm -f $(OBJ_FOLDER)/*;\
	echo "cleaning bin...";\
	rm -f $(BIN_FOLDER)/*;

start_up_obj: $(OBJ_FOLDER)/startup_stm32f407vgtx.o

$(OBJ_FOLDER)/startup_stm32f407vgtx.o:startup_stm32f407vgtx.s
	$(CC) $(CFLAGS) -c -o $@ $<
	@echo "compiling assembly $@"

$(DEP_LST):|make_dir


$(DEP_FOLDER)/%.d: %.c
	$(create_d)


-include $(SRC:%.c=$(DEP_FOLDER)/%.d)

