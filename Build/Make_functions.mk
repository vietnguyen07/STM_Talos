define get_all_folders
  dirs:=$$(sort $$(dir $$(wildcard $(1)/*/.)))
  dirs:=$$(filter-out $(.),$$(dirs))
  ifneq ($$(dirs),)
      $$(foreach subdir,$$(dirs),\
          $$(eval $(2)+=$$(subdir))\
      )
    ## recursion to sub-folders
      $$(foreach subdir,$$(dirs),\
          $$(eval $$(call get_all_folders,$$(subdir), $(2)))\
      )
  else
  endif
endef

define get_top
    local_current:=$(1)
    is_top:=$$(wildcard $$(local_current)/$(3))
    ifeq ($$(is_top),)
	local_current:=$$(local_current)/..
        $$(eval $$(call get_top, $$(local_current), $(2), $(3)))
    endif
    $(2)=$$(local_current)
endef


define get_files
    local_get_files=$$(foreach Fol, $(1),\
                        $$(wildcard $$(Fol)/*.*))
    $(3)=$$(filter $(2),$$(local_get_files))
endef

define create_d
	@echo 'generating' $@;\
	set -e; rm -f $$@; \
	$(CC) -MM $(DEPFLAGS) $< > $@.$$$$; \
	sed 's,\(.*\)\.o[ :]*,$(OBJ_FOLDER)/\1.o: ,g' < $@.$$$$ > $@; \
	echo '\t @echo "compiling $$@";\\'>>$@;\
	echo '\t $$(CC) $$(CFLAGS) -c -o $$@ $$<'>> $@; \
	sed 's,\(.*\)\.o[ :]*,$@ : ,g' < $@.$$$$ > $@.2; \
	echo "\n" >> $@; \
	echo '\t $$(create_d)' >> $@.2; \
	cat $@.2 >> $@; \
	rm -f $@.$$$$ $@.2
endef
