CURRENT_FOLDER:=.
TOP_FOLDER:=
FOLDER_LST:=
SRC_LST:=
HDR_LST:=
INC_FOLDER:=
DEP_FOLDER:=./Dependencies
OBJ_FOLDER:=./Objects
BIN_FOLDER:=./Bin
SPACE_LITERAL := $(subst ,, )


$(eval $(call get_top, $(CURRENT_FOLDER), TOP_FOLDER,TOP.top))
$(eval $(call get_all_folders, $(TOP_FOLDER), FOLDER_LST))
$(eval $(call get_files,$(FOLDER_LST),%.c, SRC_LST))
$(eval $(call get_files,$(FOLDER_LST),%.h, HDR_LST))

SRC_LST:=$(subst //,/,$(SRC_LST))
HDR_LST:=$(subst //,/,$(HDR_LST))

SRC:=$(notdir $(SRC_LST))
INC_FOLDER := $(sort $(dir $(HDR_LST)))

VPATH := $(sort $(dir $(SRC_LST)))
VPATH += $(INC_FOLDER)

VPATH:=$(subst $(SPACE_LITERAL),:,$(VPATH))

OBJ_LST:=$(SRC:%.c=$(OBJ_FOLDER)/%.o)
OBJ:=$(notdir $(OBJ_LST))
DEP_LST:=$(SRC:%.c=$(DEP_FOLDER)/%.d)

NEEDED_FOLDER:= $(OBJ_FOLDER) $(DEP_FOLDER)

CC:=gcc
CFLAGS:=$(foreach header_dir,$(INC_FOLDER),-I$(header_dir) )

DEPFLAGS+=$(foreach header_dir,$(INC_FOLDER),-I$(header_dir) ) -MM

LKER:=ld
LKER_FOLDER:=
LDFLAGS:=

OUTPUT:=prize.out

