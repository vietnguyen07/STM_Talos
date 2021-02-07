include Make_functions.mk
include Make_variables.mk
.PHONY: all clean make_dir

all: $(DEP_LST) $(OBJ_LST) 
	@echo "linking....";
	@echo "making bin to $(BIN_FOLDER)";
	$(LKER) $(LDFLAGS) -o $(BIN_FOLDER)/$(OUTPUT) $(OBJ_LST)

make_dir:
	@mkdir -p $(DEP_FOLDER) $(OBJ_FOLDER) $(BIN_FOLDER);

clean:
	@echo "cleaning deps...";\
	rm -f $(DEP_FOLDER)/*;\
	echo "cleaning objs...";\
	rm -f $(OBJ_FOLDER)/*;\
	echo "cleaning bin...";\
	rm -f $(BIN_FOLDER)/*;

$(DEP_LST):|make_dir


$(DEP_FOLDER)/%.d: %.c
	$(create_d)


-include $(SRC:%.c=$(DEP_FOLDER)/%.d)

